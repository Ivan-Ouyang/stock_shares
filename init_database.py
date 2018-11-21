from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session
from sqlalchemy import Column, Integer, String, DateTime, Float
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class stock_basic(Base):
    __tablename__ = 'stock_basic_info'
    
    # Here we define columns for the table stock_basic_info
    # Notice that each column is also a normal Python instance attribute.
    ts_code = Column(String, primary_key=True, nullable=False)
    symbol = Column(String, nullable=False)
    name = Column(String, nullable=False)
    area = Column(String, nullable=False)
    industry = Column(String, nullable=False)
       
    

def init_stock_tables(inBase):
    engine = create_engine("mysql://IT271350_5:IT271350_5@192.168.1.200/stock_shares")
    session = sessionmaker()
    session.configure(bind=engine)
    inBase.metadata.create_all(engine)
