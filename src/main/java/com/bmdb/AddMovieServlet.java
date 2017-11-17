package com.bmdb;

import java.io.IOException;
import java.util.Arrays;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bmdb.persist.DBContext;
import com.bmdb.persist.Movie;

public class AddMovieServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Movie movie = new Movie();
        movie.setName(request.getParameter("title"));
        movie.setInfo(request.getParameter("info"));
        movie.setYear(Integer.parseInt(request.getParameter("year")));
        movie.setGenres(Arrays.asList(request.getParameter("genres").split(",")).stream().filter(x -> x.length() > 0)
                .map(x -> Integer.parseInt(x)).map(x -> DBContext.get().getGenresService().getGenre(x))
                .collect(Collectors.toList()));
        DBContext.get().getMoviesService().addMovie(movie);
        response.sendRedirect("movies.jsp");
    }

}
