import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

const Stack = createStackNavigator();

export default function AppNavigation() {
    return (
        <NavigationContainer>
            <Stack.Navigator>
                {/* Add your screens here */}
                {/* Example: 
                <Stack.Screen name="Home" component={HomeScreen} />
                */}
            </Stack.Navigator>
        </NavigationContainer>
    );
}