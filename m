Return-Path: <linux-aspeed+bounces-3156-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F96D637B2
	for <linux-aspeed@archiver.kernel.org>; Sat, 20 Dec 2025 06:44:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dYFHM0SsLz2y6G;
	Sat, 20 Dec 2025 17:43:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=47.88.81.152
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766168463;
	cv=none; b=mwLUyMgK30nQB58U4FAuGXYdmFdQqdHBzisSqxJgOEcjFGUs1vyyOT9LRofcF9pQD+Po/GS+dMELTGS7f3cYj0bJdYM2myPCv9CC/nHjMqeIFdDO3IIt/Z4n0wKvgJsKXkt4g+xlZ+YXldCZhmupPFQWeeUf/SVM7wgrLr6wuWeKkUreKq89su9IJ5otIFhrmNLkT3dpScKNu9yFoKNjV6SBsfoyTH+vqre2t8IYb+gAYLWXuE9LJV3SXADfVMyZbUaaDZIKisS2FLvIpWos5Ef42w2oTPwKjBq9MOyH3R0lHQrxzbxE836jB6hPHmEaUw5hDrowciOaag0YuYne0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766168463; c=relaxed/relaxed;
	bh=+dpxgpVjronVSwUPCPFj5OzYc6xfTN7Fz/RJWrifxaw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WpyHxZ+3I0Nq8+mrjGrrIYP4VjgQaDRprMqfpu3wVCWKXE2wdZ6lZFGhMl+lgCv5qyHHOYPmiQEawqDMeK9g1gNrxCPV/qY3BR9bLthaUAB+tKrqrPknAaPn+kjEg1i2wKYjtl/QbP42EqiL/c/XdJ4B0pztcQrIM/QyOliAzSh75nj53GtZf+/6QkAaUJ9sHcXJwveqjnoTw8etYzYfJrUqEnoWac3FXfHtz4+x/Qu/iv1HM8QsB/X7q/ig9TOJaK7ELtXgSTkJX4H8N4DY+dS+WwTM0L8bBTdAaF+uYfb2YyOCPlLwSmdGQQvV47NJBKeYnU1lRYjAHnx4GusNJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=L3Mqft++; dkim-atps=neutral; spf=pass (client-ip=47.88.81.152; helo=mail-m81152.netease.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org) smtp.mailfrom=rock-chips.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=L3Mqft++;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=rock-chips.com (client-ip=47.88.81.152; helo=mail-m81152.netease.com; envelope-from=shawn.lin@rock-chips.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 4010 seconds by postgrey-1.37 at boromir; Sat, 20 Dec 2025 05:20:58 AEDT
Received: from mail-m81152.netease.com (mail-m81152.netease.com [47.88.81.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXwp23yZqz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Dec 2025 05:20:55 +1100 (AEDT)
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2de8ecb5a;
	Fri, 19 Dec 2025 22:51:48 +0800 (GMT+08:00)
Message-ID: <1ca8f181-7784-469a-b498-622a39737e1e@rock-chips.com>
Date: Fri, 19 Dec 2025 22:51:47 +0800
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
Cc: shawn.lin@rock-chips.com, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 4/5] iio: adc: rockchip: Simplify with dev_err_probe
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar
 <alim.akhtar@samsung.com>, Heiko Stuebner <heiko@sntech.de>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
 <20251219-iio-dev-err-probe-v1-4-bd0fbc83c8a0@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251219-iio-dev-err-probe-v1-4-bd0fbc83c8a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b371876c109cckunm523b6161c55b6
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpLQlZISkxISh9MSUxPTUxWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=L3Mqft++QW1keeakifFX4r26Bo0K6b98n4bO3SkNmgCq8A7i7LaIGFWE33BuWDvjygTygfaTOhEhZeN8KwRErxShB2KrucqxNKw+Kd0nc3xTFXibEhJOhbcD08iJuqEY8SBejR1zFuRW/6LxVsItsK6il0sxsFTK4A2FeCidGBw=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=+dpxgpVjronVSwUPCPFj5OzYc6xfTN7Fz/RJWrifxaw=;
	h=date:mime-version:subject:message-id:from;

在 2025/12/19 星期五 22:31, Krzysztof Kozlowski 写道:
> Use dev_err_probe() to make error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>   drivers/iio/adc/rockchip_saradc.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index 6721da0ed7bb..263d80c5fc50 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -492,10 +492,9 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>   	 */
>   	info->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
>   								"saradc-apb");
> -	if (IS_ERR(info->reset)) {
> -		ret = PTR_ERR(info->reset);
> -		return dev_err_probe(&pdev->dev, ret, "failed to get saradc-apb\n");
> -	}
> +	if (IS_ERR(info->reset))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(info->reset),
> +				     "failed to get saradc-apb\n");
>   
>   	init_completion(&info->completion);
>   
> @@ -505,10 +504,8 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>   
>   	ret = devm_request_irq(&pdev->dev, irq, rockchip_saradc_isr,
>   			       0, dev_name(&pdev->dev), info);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed requesting irq %d\n", irq);
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(&pdev->dev, ret, "failed requesting irq %d\n", irq);
>   
>   	info->vref = devm_regulator_get(&pdev->dev, "vref");
>   	if (IS_ERR(info->vref))
> 


