c = 299792458 # m s^-2
import numpy as np

def pri_to_prf(pri):
    prf = 1/pri
    return prf


def range_from_time(time):
    range = c * time * 0.5
    return range


def time_from_range(range):
    time = 2 * range / c
    return time


def frequency_from_wavelenth(wavelength):
    frequency = c / wavelength
    return frequency


def wavelength_from_frequency(frequency):
    wavelength = c / frequency
    return wavelength


def sphere_area(radius):
    area = 4 * np.pi * radius^2
    return area


def beamwidth(k, wavelength, aperture):
    beamwidth = k * wavelength / aperture
    return beamwidth


def far_field_approximation(aperture, wavelength):
    range_ff = (2 * aperture ^ 2) / wavelength
    return range_ff


def average_power_duty(peak_power, duty_cycle):
    """Returns the average power of a pulse from its peak power and duty cycle"""
    average_power = peak_power * duty_cycle
    return average_power


def average_power(peak_power, pulse_width, pulse_repetition_frequency):
    """Returns the average power of a pulse from its peak power and the pulse repetition frequency """
    average_power = peak_power * pulse_width * pulse_repetition_frequency
    return average_power


def unambiguous_range(pulse_repetition_frequency):
    unambiguous_range = c * 0.5 / pulse_repetition_frequency
    return unambiguous_range


def doppler_shift(radial_velocity, wavelength):
    doppler_frequency = 2 * radial_velocity / wavelength
    return doppler_frequency


def unambiguous_doppler(pulse_repetition_frequency):
    maximum_frequency = pulse_repetition_frequency * 0.5
    return maximum_frequency


