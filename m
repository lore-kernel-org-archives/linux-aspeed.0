Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A28606A324
	for <linux-aspeed@archiver.kernel.org>; Thu, 19 Nov 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zt+d127U
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVfV80qDLz2xH7;
	Fri, 20 Nov 2026 00:30:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795095024;
	cv=none; b=eF4ikstfJu9/YEImLr3VDBpiap8UY4BLAvZx1VEPYkJgQDVaNo23+sP0gv6EXi2v/iSk5DQdn/Zyg7rC4Ay3iscrJEfsIB2b8iqsipk3gmC6Jf8B41mph7XR9FgT/hKxBX9kboMekIuzJx9f7o7v6jhXag9TlziRQHDUdHDhmmsXi7TsOHRYcnfjZ4NDEJDf5ESpPTsyiKd8sT+NrOZMJ3j3bRpDVNArYuEDghNb4dieAeD9EnDvajMPI9ORY1FAvy1ag+c3vu+hpGdp8668aITmfGfWXVBScMpq3TV3rbf9b0eo+6VZ5/eT0z80PvnehrLOvVNQrBjIGCnNEdCh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795095024; c=relaxed/relaxed;
	bh=1EYEvcD7siuOpXvwY3Vf+JekvZisCcVk18ZnieT9Z+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7rHR+l0/40a6j5CxlpYVlYjykfTjUNViBeSftk9h6fUeMeqC5nwIZPT9sZ5PD28RntFl4lJoLZZCpFPPe+jqfGgMRzAQdtYTcxR7VmMw0ZNUPkuZJbbdeH+KjxrhExKproOy4IbRuKALvGR0O5Ibnsj/lTX73m7y1HAQyrCy9rjTcddVjij4H8rKpdTO7WJnlXcIftkaEsW2QwtXSzKK/sOcO0kExCHgg37KtWDY8oqM1jGFQuqk4M26EKgI63UKwqgbkEYJElf7pUnt/8prl5SlDKmAxzKnYv0Kb0NFifs7BKwDFM2DDr9LPhn+HGI3/Clkw3jnEp2HYD9lgE1yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zt+d127U; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zt+d127U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jVfV72WB2z2xB1
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Nov 2026 00:30:23 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id 0F870416A0;
	Thu, 19 Nov 2026 13:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 891DF1F000C6;
	Thu, 19 Nov 2026 13:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795095019;
	bh=1EYEvcD7siuOpXvwY3Vf+JekvZisCcVk18ZnieT9Z+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zt+d127UIL3Qg/8heu+JJZBZ/UiI98B0QpqkL/6LVP2N5D+D3/JFhX6yJgys2I2Kr
	 BD6CzPELRUlVKs9TiV+BgaBK87vsQYeZ/9yycDz8Dkqc8BrKGzmE4TAMJI890jjHw2
	 h+dYG9QPXcFcK2S35y0KH4zCL/ToVIifI91xdGgz3+fVxeFq20LBpsJTYtkQyAdnqS
	 kGqetxtcZ29IjRnG+N/muFfLVU7QjhIcphYQxuK/l9e69XlDkAgLoWYQ7DxNsT5/2o
	 uDjdOYmfjRrN4UN/+0sAd+A3WREYD9FHi9kLH9aeUGJD1g5+wD+JhRLPB4prVqzzAE
	 MPnTyBPCm61+Q==
Date: Thu, 19 Nov 2026 14:30:15 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] gpio: aspeed: Fix potential coprocessor bank map leak
Message-ID: <fvehiq2zts6jevimc2fmzttgh2h3v7s4hjzsasfx64cnhqy37p@qqejcrujd3q5>
References: <20261118-324f82bd41-gpio-aspeed-0@mail.sdu.edu.cn>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-324f82bd41-gpio-aspeed-0@mail.sdu.edu.cn>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 10:21:19PM +0800, Guangshuo Li wrote:
> The coprocessor bank map is allocated lazily but is never freed when
> the GPIO controller is removed. Its only owner is the device-managed
> GPIO private data.
> 
> Register a cleanup action before adding the GPIO chip, so removal frees
> the map after removing the chip and before freeing its owner.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: a7ca13826e47 ("gpio: aspeed: Add interfaces for co-processor to grab GPIOs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> ---
>  drivers/gpio/gpio-aspeed.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index dc53b2decb66..bb30bbf8c60b 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -1300,6 +1300,13 @@ static const struct of_device_id aspeed_gpio_of_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_gpio_of_table);
>  
> +static void aspeed_gpio_free_copro_bankmap(void *data)
> +{
> +	struct aspeed_gpio *gpio = data;
> +
> +	kfree(gpio->cf_copro_bankmap);
> +}
> +
>  static int aspeed_gpio_probe(struct platform_device *pdev)
>  {
>  	struct gpio_irq_chip *girq;
> @@ -1364,6 +1371,10 @@ static int aspeed_gpio_probe(struct platform_device *pdev)
>  				gpio->config->llops->reg_bank_get(gpio, (i << 5), reg_rdata);
>  	}
>  
> +	rc = devm_add_action_or_reset(&pdev->dev, aspeed_gpio_free_copro_bankmap, gpio);
> +	if (rc)
> +		return rc;
> +

You have the address of the device that binds to the driver in struct
aspeed_gpio, why don't you just use devm_kzalloc_obj()?

Bart

