import { useState } from 'react';
import { AppBar, Toolbar, Typography, Button, IconButton, Drawer, List, ListItem, ListItemText, Box, Grid2 } from '@mui/material';
import MenuIcon from '@mui/icons-material/Menu';
import vassarianLogo from './assets/VassarianLogo.png';
import BigMeeting from './assets/BigMeetingPreTreasonSplashArt.jpeg';
import Lenmar from './assets/LenmarSplashArt.jpeg';
import VassarianExiled from './assets/VassarianExiledSplashArt.jpeg';
import VassarianMain from './assets/VassarianMainSplashArt.jpeg';
import './App.css';

function App() {
  const [mobileOpen, setMobileOpen] = useState(false);

  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  const navItems = ['Home', 'Characters', 'About'];

  return (
    <Box sx={{ display: 'flex', flexDirection: 'column', minHeight: '100vh', width: '100%' }}>
      {/* Navbar */}
      <AppBar position="static" sx={{ backgroundColor: '#3E2723' }}>
        <Toolbar>
          <IconButton edge="start" color="inherit" aria-label="menu" onClick={handleDrawerToggle} sx={{ display: { sm: 'none' } }}>
            <MenuIcon />
          </IconButton>
          <Typography variant="h6" sx={{ flexGrow: 1, fontFamily: 'MedievalSharp', letterSpacing: '2px' }}>
            Vassarian's Legacy
          </Typography>
          <Box sx={{ display: { xs: 'none', sm: 'block' } }}>
            {navItems.map((item) => (
              <Button key={item} sx={{ color: '#FFF' }}>{item}</Button>
            ))}
          </Box>
        </Toolbar>
      </AppBar>

      {/* Sidebar Drawer */}
      <Drawer anchor="left" open={mobileOpen} onClose={handleDrawerToggle}>
        <Box sx={{ width: 250, backgroundColor: '#5D4037', height: '100%' }}>
          <List>
            {navItems.map((item) => (
              <ListItem button key={item} onClick={handleDrawerToggle}>
                <ListItemText primary={item} sx={{ color: '#FFF' }} />
              </ListItem>
            ))}
          </List>
        </Box>
      </Drawer>

      {/* Hero Section */}
      <Box sx={{ textAlign: 'center', p: 4, backgroundColor: '#4E342E', color: '#FFF' }}>
        <img src={vassarianLogo} alt="Vassarian Logo" style={{ width: '150px', marginBottom: '20px' }} />
        <Typography variant="h3" sx={{ fontFamily: 'MedievalSharp' }}>A Tale of Betrayal and Redemption</Typography>
        <Typography variant="h6">Embark on a journey through kingdoms torn by war and deceit.</Typography>
      </Box>

      {/* Image Gallery */}
      <Grid2 container spacing={3} sx={{ flexGrow: 1, p: 3, justifyContent: 'center' }}>
        {[{ img: BigMeeting, text: 'The fateful meeting before the betrayal.' },
          { img: Lenmar, text: 'Lenmar, the fallen knight seeking vengeance.' },
          { img: VassarianExiled, text: 'Vassarian wandering in exile, plotting his return.' },
          { img: VassarianMain, text: 'The final stand against the traitors.' }].map((item, index) => (
          <Grid2 key={index} xs={12} sm={6} md={3}>
            <Box sx={{ textAlign: 'center', p: 2 }}>
              <img src={item.img} alt={item.text} style={{ width: '100%', borderRadius: '8px' }} />
              <Typography variant="body1" sx={{ mt: 1 }}>{item.text}</Typography>
            </Box>
          </Grid2>
        ))}
      </Grid2>
    </Box>
  );
}

export default App;
