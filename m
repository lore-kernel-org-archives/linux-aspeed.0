Return-Path: <linux-aspeed+bounces-3530-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CD4E68179
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 00:12:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fK1WK2D35z30hg;
	Mon, 23 Feb 2026 11:12:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::2a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771805533;
	cv=none; b=AcMDp+7aTQdwsLOPt+asivay305Pey0uSzoW4EZfOouSnB8U6Dmpyc38UAjkm3cq5HVP01pkiK7slKLFn9ETLi6Atmnj8tszf6ybHUu7P98spVDUp5U2xh87wDobkXgex7slqgOuXS5sI6q38QjWvpH8qgSYWPavbAk7lLo3VvmJvdalP2dpNBaWV9nNLVTTes1m+7+TUKl/e+XpLeb4X2uGpP1vI+JqYBwGYYt8SgNbzrcA/vbGGHr3lCv/qTo6dtB6Mmj0s+xWGOuuRSVXoKUzv321Qrownn2NC20AGzR9upoXFPvsb5Q0kV1fAxERvQMd8JuOt71++YISJNC+Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771805533; c=relaxed/relaxed;
	bh=f/cjh3P6a7yxOJcaGA1eGYzRpZFWZsrKDRxEVGR8r7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dYIj2GOho8KNe6yBjJipTUBmbSITCQhZ65TEJqVMMzJAzZQ8XrX6ioTbV7UqSY4Y+QN9dX67W6OszgwJbVB/44arD+2oP38FHhyDpDo+wlCzTx0e6XUJHdtzKznFzHzvc/r09jvxxpBs+AS6U97obC5FLd+e4ejOYeWq/lJhR7laA5A7bQC0OBYXB8XAGnJm+XvYHtBfGPI06ZAVr8XdmWEziInU13SljX9ckyJBHJ9eYoZua2k1yIkDlRC12BGKZsQGB3GUZ3RJRDM5U6iO96yM2I9Uv4EIZ2lFZeUsOw4buWZnfG/dN0EtWwRDKo9/Cj9i+Gifoyayek03BvfZjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=HOeOB5yP; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com; envelope-from=dlechner@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=HOeOB5yP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2001:4860:4864:20::2a; helo=mail-oa1-x2a.google.com; envelope-from=dlechner@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fK1WH18ykz2yrW
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 11:12:08 +1100 (AEDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-414ffb4c0a0so3236785fac.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 22 Feb 2026 16:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771805524; x=1772410324; darn=lists.ozlabs.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f/cjh3P6a7yxOJcaGA1eGYzRpZFWZsrKDRxEVGR8r7c=;
        b=HOeOB5yPm1JFrx3/OarVsMm8tbF+K0zF33r8VUALIQtyL+AUnhaiNlCM69WSOHIuBd
         PFK221Eax9Jb/msu2De/G2XA2770D0qgBsAG0OWEPQ52jIq8hfgco9K4FSaORRr42xK3
         sK1LToR8Ti4GjHfirOGiD6/bIW+YQYxDtPcd4y4/cKxnu2+webN+cISxMEReUPrE7hDv
         Ywfj6igIg/0Chu02STMnNC1bKqiogIMxuOWpr728LxIpD5pSFXF5VL1nXc6nZegha3l5
         V6YkhWVYnLAGJzUc1YAUEZe8B6HWYubcAKJK3boHwuSGYB85arhEzRIuedF+ou742UxJ
         Q3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771805524; x=1772410324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/cjh3P6a7yxOJcaGA1eGYzRpZFWZsrKDRxEVGR8r7c=;
        b=hSLaoJF8bDK7LG0JgMDrWiEj3sj9TI38p3eDZxhYj0WvCKxLaH1gRj+y9Eo4Wu56K4
         7xnf2GYlkI//E6GjrTLmFyA1UzyDCehm5QYimAB/0pwyz+1ybQNj67am5Taka5TjcHjN
         OcYOC2C3id/dt6oCqXKY59pf6D5qHrkIebP1O5AF7h6YjZmY6AV88FAJ9CTGJY+d8z0t
         LMFBGgwttXbADVYzPSiycT6LS/VDbIrcWen6ybNqJp9phSr1ZTvUna5cNNNBPp7tR/O5
         v/zO0zxxAcQOnKri8fE7eU1xQEBNxO/J8J1/6v6A62lyrKGTQhk57UNPnFDMk49fzi72
         hubg==
X-Gm-Message-State: AOJu0YyWAyrqVKc9YtqF+IAprtVJYsLAVccGO2fS9B8+NNi9jcR/mq3K
	wh6SHqbVIGSINeafggygDvdLcDXtMxJ8XHkkocPUHlxHkh1XIQFvnF68EwsSmtpuPe0=
X-Gm-Gg: AZuq6aIF9V+7/muXr5y4Cs5GRnEKpBTxjrxo0acfogD9jshNmWAcksgmN6f/OFfemxx
	biJutygdAO5VshwnC9T3pFwudCgHQpZ7PjOSZxwWLi9xaQzejUaJwYMUJpJ//VCN+WJklZFKO62
	v9MLWfX0s0zhD9Srh2Y0XIrCO0skzeFmAsJuTU1j4VZeSXfJCJxcWTP4u6yGVMXxsHvYW756FDY
	l1ztXabZ2orPluGUlrMGqe+fEA3/Ush+fasSAHaqqMZuHeA8ynW9SS5nd6aJP5Aw6lDQzq+TnAf
	f0jZSGj4v5lqzqwzW5Nk87lBYbkbTP8yJXpFtykMtq1CC8+Dx5s3gcpAbTk9esv8Mg7CvXkZF+b
	G/RvgXt436hTbPTfAgU8vnCxXaMplw9G7A+OdCSu5zj5K+ttV+zrEzLeL0R7MIVz58F79A05SWU
	ElaxSzbaj9JWZoENTMeqJg6bBbPFI7zCp1WgBQlOJYEuzc3R5aSi36FJvhtpLdecBlcpOlfMU=
X-Received: by 2002:a05:6870:f61b:b0:409:794e:fe9 with SMTP id 586e51a60fabf-4157b1b3fd3mr3557313fac.54.1771805524220;
        Sun, 22 Feb 2026 16:12:04 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e37:2309:3937:4469? ([2600:8803:e7e4:500:e37:2309:3937:4469])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157ca3df7fsm6409978fac.0.2026.02.22.16.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 16:12:02 -0800 (PST)
Message-ID: <f5b38942-a584-4e78-a893-de4a219070b2@baylibre.com>
Date: Sun, 22 Feb 2026 18:12:00 -0600
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
Subject: Re: [PATCH v2 10/11] pinctrl: rockchip: Simplify locking with
 scoped_guard()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Emil Renner Berthing <kernel@esmil.dk>, Hal Feng
 <hal.feng@starfivetech.com>, Chen Wang <unicorn_wang@outlook.com>,
 Inochi Amaoto <inochiama@gmail.com>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Heiko Stuebner <heiko@sntech.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20260118-pinctrl-cleanup-guard-v2-0-bd36f681bdc0@oss.qualcomm.com>
 <20260118-pinctrl-cleanup-guard-v2-10-bd36f681bdc0@oss.qualcomm.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260118-pinctrl-cleanup-guard-v2-10-bd36f681bdc0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/18/26 12:09 PM, Krzysztof Kozlowski wrote:
> Simplify error handling by removing two mutex_unlock() calls with
> scoped_guard().
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/pinctrl/pinctrl-rockchip.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/pinctrl-rockchip.c b/drivers/pinctrl/pinctrl-rockchip.c
> index e44ef262beec..bbe1cf712965 100644
> --- a/drivers/pinctrl/pinctrl-rockchip.c
> +++ b/drivers/pinctrl/pinctrl-rockchip.c
> @@ -3640,17 +3640,16 @@ static int rockchip_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,

Filling in some context from the existing code...

	for (i = 0; i < num_configs; i++) {
		param = pinconf_to_config_param(configs[i]);
		arg = pinconf_to_config_argument(configs[i]);

		if (param == PIN_CONFIG_LEVEL || param == PIN_CONFIG_INPUT_ENABLE) {
			/*
			 * Check for gpio driver not being probed yet.

>  			 * The lock makes sure that either gpio-probe has completed
>  			 * or the gpio driver hasn't probed yet.
>  			 */
> -			mutex_lock(&bank->deferred_lock);
> -			if (!gpio || !gpio->direction_output) {
> -				rc = rockchip_pinconf_defer_pin(bank, pin - bank->pin_base, param,
> -								arg);
> -				mutex_unlock(&bank->deferred_lock);
> -				if (rc)
> -					return rc;
> -
> -				break;
> +			scoped_guard(mutex, &bank->deferred_lock) {
> +				if (!gpio || !gpio->direction_output) {
> +					rc = rockchip_pinconf_defer_pin(bank,
> +									pin - bank->pin_base,
> +									param, arg);
> +					if (rc)
> +						return rc;
> +					break;

I think there is an unintentional change here.

scoped_guard() is implemented by a for loop. So the break statement is now
breaking out of the scoped_guard() scope rather than breaking out of the
outer for loop.

> +				}
>  			}
> -			mutex_unlock(&bank->deferred_lock);
>  		}
>  
>  		switch (param) {
> 


