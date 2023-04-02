const express = require("express");
const router = express.Router();
const fetchuser = require("../middleware/fetchuser");
const { body, validationResult } = require("express-validator");
const Book = require("../models/Book");

// Get all the keys , login not required
router.get("/fetchallbooks", fetchuser, async (req, res) => {
  const books = await Book.find();
  res.json(books);
  
});
// Get all the keys , login  required
router.get("/fetchalluserbooks", fetchuser, async (req, res) => {
  const books = await Book.find({ user: req.user.id });
  res.json(books);
  
});

// adding books login required
router.post(
  "/addbook",
  fetchuser,
  async (req, res) => {
    
    try {
      const { key, price} = req.body;

      // If there are errors, return Bad request and the errors
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res
          .status(400)
          .json({ success: false, error: errors.array()[0]["msg"] });
      }
      const book = new Book({
        key,
        price,
        user: req.user.id,
      });
      const savedbook = await book.save();

      res.json(savedbook);
    } catch (error) {
      console.error(error.message);
      res.status(500).send("Internal Server Error");
    }
  }
);
// toggle availability of book 
router.put('/:id/toggleAvailability',fetchuser, async (req, res) => {
  try {
    const bookId = req.params.id;
    const book = await Book.findById(bookId);

    if (!book) {
      return res.status(404).send({ error: 'Book not found' });
    }

    book.availability = !book.availability;
    await book.save();

    res.send({ message: 'Book availability toggled successfully', book });
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Server error' });
  }
});


// Delete a book
router.delete('/delete/:id',fetchuser, async (req, res) => {
  try {
    const bookId = req.params.id;
    const book = await Book.findById(bookId);

    if (!book) {
      return res.status(404).send({ error: 'Book not found' });
    }

    await book.delete();

    res.send({ message: 'Book deleted successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).send({ error: 'Server error' });
  }
});

module.exports = router;
