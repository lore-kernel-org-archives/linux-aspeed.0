Return-Path: <linux-aspeed+bounces-3615-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6ECFCB60B
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Mar 2026 15:22:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS9Bj1QWmz2ySS;
	Sat, 07 Mar 2026 02:22:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1233"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772810557;
	cv=none; b=hjnmMTLymV9t+v1qxKtHFmWdgne11e8/Vi5S5rPBbzlbXWcM4U9ms89WUfSFUVFrh2LlmE2wu0rMGq0NvdgwEW4tkeumOxwG2UpPux1xn0DpkA3nd/xjZYBM+jdNy/0DL3qSFhGnEcFpx7ABvQ04Bhls1Sq3n7/S6SxTKmXSnz7RzZwb3VoA3cSJT8XTQT8SAbUT4s65yJdkoSxrNl2Z3dQkrmMjsXq8kvLPV0soyJlNafARaZ+EsY5FlEvGzWzsuHftvyURRss/Ynd3Dfg4aVpuGO61P0G5AvubmNUdDPOE3V9iytDfJCK2QWazBejAhWNV6SihbqNwZYQyyP8g2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772810557; c=relaxed/relaxed;
	bh=Z6XDLuG2g5D0dtVulOb92ZhTkqEZkXM/BQ7MGxoQVFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QsrWswcTM07+Bme1Hvicfk51r56MPjAMKRVtZowH56Flh3Tj+tdcMr5DHr8x+hkLrZXOaZI2toJ3chy2OC5TVhSy9TAfmppiin0JubR/Wj5QBWLPY7FQkOhM6vJbgwWGOObp7EUunaHNxfG9UE4fYOzzkShsQjfDsAAazhE4FFXHe43xGa8xQzW0J2RLdjsyX+0i6OTABB9yJY4JH021HbuUXja8qJmmLBUf/lsdsjETW3GQNoqAMqfH+5SKqQOKpuNO5To+qpwEXajsV7JHWj+sst28C1CiyuhyUBYZIo5iiM8oCjnL4/DD8goPOp9GmXJ12Fmucx8xNkZuY3iLDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ClpyujKT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ClpyujKT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1233; helo=mail-dl1-x1233.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1233.google.com (mail-dl1-x1233.google.com [IPv6:2607:f8b0:4864:20::1233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS9Bg1XKQz2xqm
	for <linux-aspeed@lists.ozlabs.org>; Sat, 07 Mar 2026 02:22:34 +1100 (AEDT)
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1271257ae53so11323453c88.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Mar 2026 07:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772810551; x=1773415351; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Z6XDLuG2g5D0dtVulOb92ZhTkqEZkXM/BQ7MGxoQVFU=;
        b=ClpyujKTY69+TDLSQLBO3jv4xQNrV6PKUsML+mhesoZ2MBab4Aalfmo/wUwO0moLwJ
         Pp9l0NnxgGCBhZ5u8U3Cf/fsvpKcgSPsAVRZeJS+KUa7bdous8ebhcp/4+zEDjPWEGC9
         qDHMBT/yqq2k121zKcEOnpJhmE0JEbVlhp/UIvznTtKUqpJRoZtwYM8u2prMojZ6GHL+
         nl6j+sVGkp+nT7QzDTrsBlv1J6reY7+jPPLBenLPwKxdEWZd7jQrPOumE0C0Ie+Nvcev
         k77PpqEECoi/fzzkhzzNoJX/7PA+leHD/OYYLHW+OjClyQPs6j2eSPkeWTzdo9sg49kJ
         BYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772810551; x=1773415351;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z6XDLuG2g5D0dtVulOb92ZhTkqEZkXM/BQ7MGxoQVFU=;
        b=XTgO1y0j6pNLEkmRkMOgniT02MWHUwAHQOfbE9w4JS2svjilwQDczhlH0P1WbiK7cF
         TR2pNv6hirCBZGgaTUQUPym7W9OtY+khZmaYv41jLsVfyWdcFLY3i/ahf53gHzTLcqM5
         wdfLnmgZvxB1AQutOlVHcnAto8sPtJF5B/n+fFMMVxiD3vOwMbc5K7+2BBJHQPPFoPel
         mYrPGl4xZHfS3MktRgOyFeBcgU3wlC03OrrXrG0yCqbawEeMhtfkY9lv4XEJnqKC/XfT
         h+eHxOFU7oGtQDNwupSflhpspZgfT9PEekK1fe7rLsSJQAWgRi5wqB+WITFFyNWEm6wq
         LGKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVRvoFf2hqTQjrKvcjQxAnHZUYvJUoEFrXO4jvBbLn7Y1Kaen4WlUassGWl0/Ys2QptrhX6c/HKv+IZAk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy68nQ7KYmPJZEplqzcD76I6gIzkPIH0uEuQnElKsK88Q7f7vZq
	WS3LFeHE1pl0aSBlomJUyLCZGWBKiC6JojNk3/kV3wBZkyA9rvhpqDVK
X-Gm-Gg: ATEYQzyGRHvRzOQJ7ElClo635h1iuV2fvOfkuuEmcRTaJy7YnK09zUuXk2wuB+jIZjQ
	U4K2ZbAi514XcGCWTt/63uZh0vYvgd9H4w0ojYvLOrqHlXWwNJMVSM5J53qZ9XXOEbeoChkxHd0
	g+1E8FZdSkkNQyFo1NDY2igIZrFCzYqOrk/JAxX2scJHs69XF6Av4V71XioktmJ5vrKGZlfAHaA
	5/kCVQhCeRCglGe07/8fYgTf+EC0gc21Uz+i4vd3XfAejlu9tCzkWJNZlsYblZW0jhsAapKPPls
	yRPLtj2QK2+GVBWZbrgPFIGMVkZdLRikj6/uo+AE0LQaiNgF6jR1KxlSWOmmx7ZLNHdB3ypYEyp
	Hcpb1OV1SOx7BGrdiXe/T7HA+GpXm5dbSAlaieGdqxPF+a6NNuEjhzfIkfG0ywakdXALQ8iKXTY
	39N2vKhgKNwu+0UKSonXRlTQrSnRW6X72Zp/KEyU4cBOarm6kwNe+uB1ZO6TqRZLUtL2doooKh
X-Received: by 2002:a05:7022:e28:b0:11b:9d52:9102 with SMTP id a92af1059eb24-128c2d9b28cmr1184560c88.6.1772810551074;
        Fri, 06 Mar 2026 07:22:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f5a102sm1441985c88.13.2026.03.06.07.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 07:22:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b4629b96-2e5b-45b7-a72c-dc090a5c15b4@roeck-us.net>
Date: Fri, 6 Mar 2026 07:22:28 -0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (aspeed-g6-pwm-tach): fix driver data handling in
 probe/remove
To: Billy Tsai <billy_tsai@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260306-pwm_fixes-v1-1-e8ede6fbaf47@aspeedtech.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260306-pwm_fixes-v1-1-e8ede6fbaf47@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/26 22:44, Billy Tsai wrote:
> Ensure proper association of driver data by setting and retrieving
> the platform device's driver data during probe and remove.
> 
> Fixes: 7e1449cd15d1 ("hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach")
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> ---
>   drivers/hwmon/aspeed-g6-pwm-tach.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/aspeed-g6-pwm-tach.c b/drivers/hwmon/aspeed-g6-pwm-tach.c
> index 44e1ecba205d..0c03d272279a 100644
> --- a/drivers/hwmon/aspeed-g6-pwm-tach.c
> +++ b/drivers/hwmon/aspeed-g6-pwm-tach.c
> @@ -490,6 +490,7 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
>   	if (IS_ERR(chip))
>   		return PTR_ERR(chip);
>   
> +	platform_set_drvdata(pdev, chip);
>   	pwmchip_set_drvdata(chip, priv);
>   	chip->ops = &aspeed_pwm_ops;
>   
> @@ -519,7 +520,8 @@ static int aspeed_pwm_tach_probe(struct platform_device *pdev)
>   
>   static void aspeed_pwm_tach_remove(struct platform_device *pdev)
>   {
> -	struct aspeed_pwm_tach_data *priv = platform_get_drvdata(pdev);
> +	struct pwm_chip *chip = platform_get_drvdata(pdev);
> +	struct aspeed_pwm_tach_data *priv = aspeed_pwm_chip_to_data(chip);
>   
>   	reset_control_assert(priv->reset);
>   }
> 

The probe function registers aspeed_pwm_tach_reset_assert() with
devm_add_action_or_reset(). Why is the remove function needed in
the first place ? It seems redundant to me, and even buggy since
it asserts reset before its users (pwm and hwmon) are disabled/removed.

Thanks,
Guenter


