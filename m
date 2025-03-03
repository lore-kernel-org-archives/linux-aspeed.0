Return-Path: <linux-aspeed+bounces-915-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C4BCC282D0
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Mar 2025 22:41:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6DLf5Lp6z30Sw;
	Tue,  4 Mar 2025 09:41:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=67.231.152.168
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741009891;
	cv=none; b=iEeHksWW0CyFx/fZrL1hUEXbdywnwlPXTquLPSn4X9Mz8nwdOgwnKFDywhmfTckl2slh2Uncf7mpoywrXByECPGiXesWAxkNpv/G/4sfA4AnSTMwhTW7VM15Y3s/oi4vd9vCyI/Ri2+z5LLKEnF2yYky9kIzn0ubQgPJzbNhsHYPmbbFNDypy7CC2Q/C+DA417e9oE+wrpQofKFYjJa3ToQcpXbZJADOtswuSEtE2OV65qMWu0+hXXo6GN3ZGmMHIX/2nMiHkAj8+wUn0q0jggBrrsn58aqTMMk1cWkvtqvg4KGYvH/89nSw7o6ZBE/S0iJf3JM36rNKoP08a5nz3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741009891; c=relaxed/relaxed;
	bh=ofmnRVwI5AT62ptxh8zklk/N01TYJ0oFg8f5/KIUZRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ozWj94N9303/M8qY/yJ5o/bPRAZD8QVsUZ5U3Cfh5z1MAdte3pKQp/dM0FNRCns7Kc0jLlLD+CFLlJJZwQsvlkS7Ww9fIcJA0Ie7GbQZ8irOvoQfKY7E852WgFgIl1PLqtTWn8g6hRhEO9UeDeWhudT9dJoftTeEKUUPPh1lvt5DFCzYnNkI0kjPFj8ePL503JctDC7MvyBRrs7bRZcA7L9X1Nd5PwEcn1kY9/EYglIqEevr3vzShCfCc0zWSsfRwQWU2spBqk5+e/MLMkGl6J5nIF9Du/DF6g8CyASEW1w8TciTM5XBT8XjkkkUIJ6fiBpfGD+aHKHWUKhFuOi69Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=F6wdiybK; dkim-atps=neutral; spf=pass (client-ip=67.231.152.168; helo=mx0b-001ae601.pphosted.com; envelope-from=prvs=21578c635b=rf@opensource.cirrus.com; receiver=lists.ozlabs.org) smtp.mailfrom=opensource.cirrus.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=F6wdiybK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=opensource.cirrus.com (client-ip=67.231.152.168; helo=mx0b-001ae601.pphosted.com; envelope-from=prvs=21578c635b=rf@opensource.cirrus.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1073 seconds by postgrey-1.37 at boromir; Tue, 04 Mar 2025 00:51:29 AEDT
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z60bP3TVRz2xdg
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Mar 2025 00:51:28 +1100 (AEDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5236w7Hs006077;
	Mon, 3 Mar 2025 07:33:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=ofmnRVwI5AT62ptxh8zklk/N01TYJ0oFg8f5/KIUZRw=; b=
	F6wdiybK2ED4uAxZOAJ/RRTtc+TbrgGGRp7AsLBjfNmeL1wxKEJe1gpttdgFAZQQ
	aygpqZQDL0He9/cn7WEOggadA7TgBV94vVupVnreLa1ZfKSWLnpeNovjZ0o9eyC/
	BDOwxgQ9w5V98ZV5k7y2uCBojEfbl6eO8A9BVEphTGXn+nG98/KF+LmSaCxm5QxL
	gwZnIK/MUTFJNIPctafUXvydaEtKH/23TqUrELy/xlvQCOc7TIdT+iOC9LnuDmW3
	q+w2QcBUh3Vxi31LaC6G+AMvTrlFW3vech1ZZUmPbzC0V4UbwTPa7El2/5x0XEV8
	jDLmZRWhEvTMuB7mDkGsEg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 453yhmcw74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 07:33:11 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 13:33:10 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:33:10 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E67B2820248;
	Mon,  3 Mar 2025 13:33:09 +0000 (UTC)
Message-ID: <84b7c543-7e81-4a20-9f58-7ddf6b2001e5@opensource.cirrus.com>
Date: Mon, 3 Mar 2025 13:33:09 +0000
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/15] gpio: arizona: use new line value setter callbacks
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mun Yew Tham
	<mun.yew.tham@intel.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery
	<andrew@codeconstruct.com.au>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
 <20250303-gpiochip-set-conversion-v1-11-1d5cceeebf8b@linaro.org>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250303-gpiochip-set-conversion-v1-11-1d5cceeebf8b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: CRfd2hqIDBqS4F2QrofR-T9cJdEBrOGR
X-Authority-Analysis: v=2.4 cv=UeirSLSN c=1 sm=1 tr=0 ts=67c5af97 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8 a=IHiEukr3ZQpEQQ-4GLUA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-GUID: CRfd2hqIDBqS4F2QrofR-T9cJdEBrOGR
X-Proofpoint-Spam-Reason: safe

On 03/03/2025 1:18 pm, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/gpio/gpio-arizona.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
> index c15fda99120a..e530c94dcce8 100644
> --- a/drivers/gpio/gpio-arizona.c
> +++ b/drivers/gpio/gpio-arizona.c
> @@ -121,7 +121,8 @@ static int arizona_gpio_direction_out(struct gpio_chip *chip,
>   				  ARIZONA_GPN_DIR | ARIZONA_GPN_LVL, value);
>   }
>   
> -static void arizona_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
> +static int arizona_gpio_set(struct gpio_chip *chip, unsigned int offset,
> +			    int value)
>   {
>   	struct arizona_gpio *arizona_gpio = gpiochip_get_data(chip);
>   	struct arizona *arizona = arizona_gpio->arizona;
> @@ -129,8 +130,8 @@ static void arizona_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
>   	if (value)
>   		value = ARIZONA_GPN_LVL;
>   
> -	regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
> -			   ARIZONA_GPN_LVL, value);
> +	return regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
> +				  ARIZONA_GPN_LVL, value);
>   }
>   
>   static const struct gpio_chip template_chip = {
> @@ -139,7 +140,7 @@ static const struct gpio_chip template_chip = {
>   	.direction_input	= arizona_gpio_direction_in,
>   	.get			= arizona_gpio_get,
>   	.direction_output	= arizona_gpio_direction_out,
> -	.set			= arizona_gpio_set,
> +	.set_rv			= arizona_gpio_set,
>   	.can_sleep		= true,
>   };
>   
> 
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

