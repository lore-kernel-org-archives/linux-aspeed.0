Return-Path: <linux-aspeed+bounces-3616-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE57FFCB61D
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Mar 2026 16:13:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSBJz2DZsz3bfV;
	Sat, 07 Mar 2026 03:13:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772813587;
	cv=none; b=kpLxja+B2fBGFMCtV5McC7pIkiRsJ0VsNyWn6erJi6lhMCE9Yu/qsxANyWNSYzTCd+3X52Z4jPDwxUJ36pJpXQgE3uIYd2kNFW0BfMenI0SkU+pI+QprjLiCadHXEywZAY9HwE18wNCY6R4Fd3ArGpe5oA3BkBx0m+cSpWFZEq3LPIaOYjvn717Id3UKinzhVZujbpiBVFGMGYEenhzE4uQG37NzEbiF2S0dbH2ZWMCQSgLY5x2k2P1FF4x7tBkS4+KaaR5VdsMdUZdsjpCSGhs0AwN7TzifXuZJK1p1885mfjoVtckV/1MMLuZMiZmpyjXJQFIu+i6nfCQLahr3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772813587; c=relaxed/relaxed;
	bh=2ExyNVSWsZEiPhZCTeAKx/MrxZrOY+AoCmCT2YcRTRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2bX3R3/aOWfZplHy5gT/FecZWKDwjtQyzVSufrK0p+DiHOds7gX1L3Jx5jjERQyHTYkA1q1yZojou90KIpoRD0KyiExvxainT96lkvRQ1hpEZ+LoJajV/tk/R3bgPyTMCSQN/3m/hSUBRTYkD6+CopUZGyu0jcyjdOMrP4HCXsVMQfQ9UKE0YdX1JLduwzASXvqqQdW2lAxF338A4p1gSEgoVsT0Va9cObn/B+DtHANfD+x2rK+5Kow0hy4fyL66PoV7Kkg0yrwPKWRXwRWOrn1agsuHjkupaUNYeSH7mKWz417gUVmJm1HXweZKN2USft+sl/Ee3+1H3vHe3a9sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jQP6ifg9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=jQP6ifg9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fSBJy3pddz30T9
	for <linux-aspeed@lists.ozlabs.org>; Sat, 07 Mar 2026 03:13:06 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-2be19f05d7dso805883eec.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Mar 2026 08:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772813584; x=1773418384; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ExyNVSWsZEiPhZCTeAKx/MrxZrOY+AoCmCT2YcRTRo=;
        b=jQP6ifg9LjeCJTLYD8hkddakNgFYqeoTC3yjp5f+htqVWbEMyyCy46pIS80LY+J/Ii
         2dSp9REqwmOKIf0cCUb2LdycNqcgm4HTjqPF6cZNqxpMafnHnEtaZ9N10PtAe6FW9Wxo
         6Clrpt9RFmbINxtmnaYNAIh2fSY+wntetaR8D29W+TB8jTeAM2VyzcXW1YRsnctp1jDk
         TVQKGwNOopMLaeiKODMMFro2cyY8Nemhv8mKrL2FXMRm4YNylU3c7Ik21lV+REPMBVrM
         IaLc/orDlzlU1/eHfFCFv3fLailPc6fbmLunxmvsbuHidqFaVZXWV/qXNM6qCwGmbDIA
         CPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772813584; x=1773418384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ExyNVSWsZEiPhZCTeAKx/MrxZrOY+AoCmCT2YcRTRo=;
        b=XVDROUWeE587hMIOPwsPrKGlD2HTUv3LvMhq+tZiwta2SQcrWYddiCXcImU20GPuFm
         /6fG1FI4riKcQAg0SoOySTWPafYZ1eSH+EOLeOQdzR0bJKrvg2ogEUsk211dhguhS/O0
         iX4vmiZLN7sVMx4g1J+Mi9rvejL8UK+qSCo+eOaD6LlNz9Bqv3xXewzLX3jCiBBUnyO5
         4kYFZtN+2ukIteAyqXeKzXxm265cwqMGgiE3hGFYpCU3//mg83AeE0DYPcsbeZdDdBKU
         QGrNG192nx9jEOJ3kYyNlxPMV1/on7ahtsPEnfIkkdzjPRRDp53kAmUQ1/izFHaI0Va7
         p/eA==
X-Forwarded-Encrypted: i=1; AJvYcCUg7jZ4tvqr9/RTqalQRoLFwBCWk0r+i97b4MpTryuTAqn8zgQbYciwNKCrf554fD/ZjV8vCKHwl7W2xAI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOrEVn6qSMZpCQZ1qLr58xRMEGsk3A6A3SvI+NB+stV4/TgqHy
	X6C9/x81tSUhgQ1LXnSE5ZOqGEzqFUB5nbVSp2O8Y2XHtqIA/444RRYB
X-Gm-Gg: ATEYQzxzqHgWGyZ5DC7IcVV1BmsnsvsbRW5r0/XZwyzLzsHbn+3BwcruYjMu9eD8Iee
	AL/xuvyjFs058PTr2yh/CPcvUsLN7ysYyaOPXfaCBjqs3sGxSzxtwiOny/stu3XDksU4V2ElzFN
	ShValDCoXSg8v3bubASM9sWM1hvmi6YTTgUPjtxwtEiXWbrsMRRtcnrecD2NFbI+x9rY9fedXTQ
	omXv8pywKDKJToDX5EqK6e2S8WkZa1L7jf+pdKTsaY5BUALEBlq+n41UQzkZkxB8+E+W/XBkzBb
	zHJ5t5ppMb3bhtsXVzFeuLZXYngskYLvgbtcHlgMO1HTsypUmod4IeuWM37GCGCVq1iUn7AHA9e
	N6yyqEFMp/PQbrZt6yjNzxkhuwNhsMc1ncWrRxmLbpPJC4TE1DNmswHoX5RwpwiF6qqKeufgjK1
	utvetgw1UwKl9xVFu92oSjWgE0kEbQEBZf8CoM
X-Received: by 2002:a05:7300:320a:b0:2b7:fdb6:ccf2 with SMTP id 5a478bee46e88-2be4de99574mr1150793eec.13.1772813584166;
        Fri, 06 Mar 2026 08:13:04 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f94823esm1578036eec.20.2026.03.06.08.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 08:13:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 6 Mar 2026 08:13:02 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aspeed-g6-pwm-tach): fix driver data handling in
 probe/remove
Message-ID: <e6c06c88-d2cd-4501-8a15-b89ba5a36e5f@roeck-us.net>
References: <20260306-pwm_fixes-v1-1-e8ede6fbaf47@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-pwm_fixes-v1-1-e8ede6fbaf47@aspeedtech.com>

On Fri, Mar 06, 2026 at 02:44:31PM +0800, Billy Tsai wrote:
> Ensure proper association of driver data by setting and retrieving
> the platform device's driver data during probe and remove.
> 
> Fixes: 7e1449cd15d1 ("hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>  drivers/hwmon/aspeed-g6-pwm-tach.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
> index 44e1ecba205d..0c03d272279a 100644
> --- a/drivers/hwmon/aspeed-g6-pwm-tach.c
> +++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
> @@ -490,6 +490,7 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  
> +	platform_set_drvdata(pdev, chip);
>  	pwmchip_set_drvdata(chip, priv);
>  	chip->ops = &aspeed_pwm_ops;
>  
> @@ -519,7 +520,8 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
>  
>  static void aspeed_pwm_tach_remove(struct platform_device *pdev)
>  {
> -	struct aspeed_pwm_tach_data *priv = platform_get_drvdata(pdev);
> +	struct pwm_chip *chip = platform_get_drvdata(pdev);
> +	struct aspeed_pwm_tach_data *priv = aspeed_pwm_chip_to_data(chip);
>  
>  	reset_control_assert(priv->reset);

AI review has the same (and more) concerns. Here is what it has to say:

Does asserting the reset here place the hardware into reset while the sysfs
interfaces are still active?

Since probe uses devm_pwmchip_add() and
devm_hwmon_device_register_with_info(), those devices are unregistered
during devres cleanup, which happens after this remove function returns. If
userspace accesses the devices before devres cleanup finishes, it could
access an IP block that is in reset and cause a system hang.

Also, since probe already registers a devres action
(devm_add_action_or_reset()) to call aspeed_pwm_tach_reset_assert(),
this explicit assert appears to be redundant. Can the remove function be
dropped entirely?

This isn't a bug, but probe calls of_platform_populate() without a
corresponding of_platform_depopulate(). Using
devm_of_platform_populate() in probe would fix the leak and allow
deleting this remove function.

I think all those points are valid.

Thanks,
Guenter

