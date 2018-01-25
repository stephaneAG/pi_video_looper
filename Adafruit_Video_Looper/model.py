# Copyright 2015 Adafruit Industries.
# Author: Tony DiCola
# License: GNU GPLv2, see LICENSE.txt

# modded by StephaneAG
# thx, kudos & long live Adafruit !

import random

class Playlist(object):
    """Representation of a playlist of movies."""

    def __init__(self, movies, is_random):
        """Create a playlist from the provided list of movies."""
        self._movies = movies
        self._index = None
        self._is_random = is_random

    def get_next(self):
        """Get the next movie in the playlist. Will loop to start of playlist
        after reaching end.
        """
        # Check if no movies are in the playlist and return nothing.
        if len(self._movies) == 0:
            return None
        # Start Random movie
        if self._is_random:
            self._index = random.randrange(0, len(self._movies))
        else:
            # Start at the first movie and increment through them in order.
            if self._index is None:
                self._index = 0
            else:
                self._index += 1
            # Wrap around to the start after finishing.
            if self._index >= len(self._movies):
                self._index = 0

        return self._movies[self._index]
        
    # == Tef edit ==
    def get_prev(self):
        """Get the prev movie in the playlist. Will loop to end of playlist
        after reaching start.
        """
        # Check if no movies are in the playlist and return nothing.
        if len(self._movies) == 0:
            return None
        # Start Random movie
        if self._is_random:
            self._index = random.randrange(0, len(self._movies))
        else:
            # Start at the last movie and decrement through them in order.
            if self._index is None:
                self._index = len(self._movies)-1
            else:
                self._index -= 1
            # Wrap around to the end after finishing.
            if self._index <= 0:
                self._index = len(self._movies)-1

        return self._movies[self._index]
        
    def get_by_idx(self, idx):
        """Get a specific movie in the playlist by its index.
        """
        # Check if no movies are in the playlist and return nothing.
        if len(self._movies) == 0:
            return None
        else:
            self._index = idx

        return self._movies[self._index]

    def length(self):
        """Return the number of movies in the playlist."""
        return len(self._movies)
