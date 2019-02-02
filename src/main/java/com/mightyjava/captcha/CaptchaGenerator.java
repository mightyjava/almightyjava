package com.mightyjava.captcha;

import org.springframework.beans.factory.InitializingBean;

import nl.captcha.Captcha;
import nl.captcha.backgrounds.BackgroundProducer;
import nl.captcha.backgrounds.TransparentBackgroundProducer;
import nl.captcha.noise.CurvedLineNoiseProducer;
import nl.captcha.noise.NoiseProducer;
import nl.captcha.text.producer.DefaultTextProducer;
import nl.captcha.text.producer.TextProducer;
import nl.captcha.text.renderer.DefaultWordRenderer;
import nl.captcha.text.renderer.WordRenderer;

public class CaptchaGenerator implements InitializingBean {

	private BackgroundProducer backgroundProducer;
	private TextProducer textProducer;
	private WordRenderer wordRenderer;
	private NoiseProducer noiseProducer;

	public Captcha createCaptcha(int width, int height) {
		return new Captcha.Builder(width, height).addBackground(backgroundProducer).addText(textProducer, wordRenderer)
				.addNoise(noiseProducer).build();
	}

	@Override
	public void afterPropertiesSet() throws Exception {
		if (this.backgroundProducer == null) {
			this.backgroundProducer = new TransparentBackgroundProducer();
		}
		if (this.textProducer == null) {
			this.textProducer = new DefaultTextProducer();
		}
		if (this.wordRenderer == null) {
			this.wordRenderer = new DefaultWordRenderer();
		}
		if (this.noiseProducer == null) {
			this.noiseProducer = new CurvedLineNoiseProducer();
		}
	}
}
