FROM jekyll/jekyll

ENV JEKYLL_ENV=production
CMD  bundle exec jekyll build