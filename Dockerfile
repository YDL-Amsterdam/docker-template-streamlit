FROM python:3.12.5-slim 

WORKDIR /app

RUN apt-get update && apt-get install -y nginx 

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .
COPY nginx.conf /etc/nginx/sites-available/default


EXPOSE 80
EXPOSE 443
# Start Nginx and Streamlit
CMD nginx -t && service nginx start && streamlit run app.py --theme.base "light" --server.headless true --browser.gatherUsageStats false