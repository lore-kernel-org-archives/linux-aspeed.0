Return-Path: <linux-aspeed+bounces-2635-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF46FCCF9E5
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Oct 2025 14:08:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cwFhm2md2z2ypW;
	Tue, 28 Oct 2025 01:08:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761574088;
	cv=none; b=DYIFOyt3XiowRuz5xbhlN/rsm2qndLhJ6pATnFRG02CVcqRwi18IfWeF9iTchrgT6/ecOGBhYl8gdqaGDk4yEj3v41V67J9/xLo+gMM658LkLnjbzdLmLvkHywg6WrCs28fiQZ9phpKZxhMbLbHYabLdG5g8u7W1bmgfrszbkRe2h54yhK5gyw8Cjq7zRX2FYhRtWzkxVUFtxtElzRPbSagCzaKVpZC9slmcC4E1u1vdjo86ntrqFn0pgwbU8IhG4Hc1Uz1pdzlY2nLj4nfI/L2UeXNMzEIzDSn9d3cwTAzN/yq/fyO3HPbqFh1PpsK3WCPK1tdD3u4IMgDg14p99w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761574088; c=relaxed/relaxed;
	bh=Nt0rohkfCTM02pp4Kdp4o2E48gt9AIEFWJolS1UaaMc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dthqqQP6bt6I0qIGV+Xpqbz+ZxFIwRr8yP7eecBk6pz/BvnOxSzgatCF0F79/fsN6cFF55nvesQLi8T8izBRapwB4xEkCcZpcYTVcj32PjiGTLFJCqzWrByrCnFFH3EQoYuSuW0fckvrq9xQZxiAmSGEha7YcnpJMPvJ6JOTINoaHgeVr3T8cCWYejCtc7k4D0dw9o5Ahbzfcn8E7RMBjptaTeT5U3acsW8ThLw3MIEbk+7tr1fgAH5ejwkm2qWtVoVmIYkmEesEKzZIP7CgfAm+gkro9ZHe8u5qhyhL6Ox9kfFeB09mqAlj6MODeAed1QRj7o4hwGeyAzHV22RFFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AmL0bIdq; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AmL0bIdq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cwFhl5nd9z2xQ6
	for <linux-aspeed@lists.ozlabs.org>; Tue, 28 Oct 2025 01:08:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 80A87601FD;
	Mon, 27 Oct 2025 14:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAB6C4CEF1;
	Mon, 27 Oct 2025 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761574085;
	bh=G5enwOxx/IokudK+Rl23Z3f4vUmuTwxMyx1zaA1SnkM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AmL0bIdqC7DBYq9C/TSivDw3ClX+wqW/taBwy56Vwhx/Ke6hIHkHVN0k80ijlVoFA
	 4GR7721eu8ej9qR6OEOlyvaDkJCjLSsY7NtMtJyqL2TdpIelAKlqN1KMQX8mFVtlxS
	 cWIsVIQtOARzYUrPvA1TT242Fm5pAgXWzNm7o3sK9oBZsr3fWdTVmGtb1zLMOMGlUk
	 8IWNs4TT8vXjfC5AbssU1jv2QQjdhs2kxdnPVbQv9a6q5F44tu3nn9SXvYAaAL1jCy
	 eAFuUZSRcBna9XgYzCXsoSkpAu7zBccivRewC3+73T3daec2Xb1Ij6IkAOBHEsc931
	 E2ZSz/D71CJ+g==
Date: Mon, 27 Oct 2025 14:07:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
 <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] iio: adc: clear reference voltage bits before
 configuring vref
Message-ID: <20251027140759.3d3149bd@jic23-huawei>
In-Reply-To: <20251021053918.3008654-1-billy_tsai@aspeedtech.com>
References: <20251021053918.3008654-1-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 13:39:18 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Ensures the reference voltage bits are cleared in the ADC engine
> control register before configuring the voltage reference. This
> avoids potential misconfigurations caused by residual bits.
> 
> Change-Id: I03c036436f376ced8a19fa5d407b7bbb377ae721
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Make sure the patch title includes the part/driver name.

iio: adc: aspeed: ..

+ the stuff Andy raised already.

Actual change looks correct to me.

> ---
>  drivers/iio/adc/aspeed_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 1d5fd5f534b8..8ab29948214a 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -415,6 +415,7 @@ static int aspeed_adc_vref_config(struct iio_dev *indio_dev)
>  	}
>  	adc_engine_control_reg_val =
>  		readl(data->base + ASPEED_REG_ENGINE_CONTROL);
> +	adc_engine_control_reg_val &= ~ASPEED_ADC_REF_VOLTAGE;
>  
>  	ret = devm_regulator_get_enable_read_voltage(data->dev, "vref");
>  	if (ret < 0 && ret != -ENODEV)


