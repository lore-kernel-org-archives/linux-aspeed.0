Return-Path: <linux-aspeed+bounces-3189-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F976E66886
	for <linux-aspeed@archiver.kernel.org>; Sun, 21 Dec 2025 12:05:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZ0MJ2TrLz2yFW;
	Sun, 21 Dec 2025 23:05:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766318700;
	cv=none; b=ErvQQnzgnvz6NfBEuLEyGJnDBz15HX69SmCRhba3Y6ni3/uNJD6Iy8WxXhAfGmEt50f+9KaYmCTaiTlyzRUJw0q4BaCEG0Is80boVQzdnErAENRlIVm7gWAcgj0OakXxju6M5vC2K0uCv1Xqz54GnDB1aM73T8uY7dcVjffvNwSBtE70P2tH/BXRmWWE4oju1jOSrSeJULNrupAE1tOpGWO+FfDVcINRKowgVF/LPuz5Sw2FvdApYmdMjIKtD3nNlYv1HjHDaXIIXygXoAbm8iWufXspVLciwg1qeDpTCwWdhz87rhnRPG43fJ55YFIO9Ak/o3YIrt3sJ4baYjp8bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766318700; c=relaxed/relaxed;
	bh=MBRUg+4Qb7okmxOYh3kLMzKaVVwRJ/8o83coAVZieEg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RF6qqQ5yWO7lt6W/JroW3zBBCK5hDuCSZevpGGg2us1sZ/PE1tudDgyIqVXhYe2Bv/JTxV8Jb3V1HiG9xKG+5P7gG8/zAQOLZ4ipAwPUXVCzwxe+AYaYN3DZX0fwRkWH7KNN28xLGwlkBn9zGG2/qJ3BSVai7Bs6UAxeDZ2H0co4c6hta4GjAiHqqJLAgS8ixftJhUCZCf4paE31zDqYiHGTdN8eb8Suq3ssUE4xCJg+aQUPixWzb0m+B9Zb6PsViuqQ/szoGjccU/KpTgAN4NNc1HZJ8l1DYYxQzidhTcUju116xuFEQ34X7Bxak3BJpuMW1RppgBnEHRrxbJfg+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kSjOlOk3; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=kSjOlOk3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZ0MH5gq8z2xQB
	for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 23:04:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C31A060007;
	Sun, 21 Dec 2025 12:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBF7C4CEFB;
	Sun, 21 Dec 2025 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766318665;
	bh=vYJHXTF57S2uWIWZSnj37Cbd8d3rIPZwHikEoAhE4qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kSjOlOk3h9BEnPlVU+aF/hIoaQV4c+oE2pmS+dEjUHl1yr+qW1KFlR8WM8sJ2bVd4
	 qG9vydCViH89KPRGzVk6N89j4gByJknCPPjmfXkB/xfnei0gPVtOQLaxmc2CEMYYAW
	 4cO6SbQTlo0TdXY/UrnfGdQ/rPWYIR9bfyysAGRF8P8CKYk+83V7PnQN5jvsJZorgO
	 gcY2l+ehX46+G4byGX25XLKjXZhj9K+AiEiiV7IJCP3myCkXSVy4Z4uhTxvXMDcOB3
	 3hmzaUdRhhnfbZzIM5IbaNdiEk6GEPy41lgxBviQenD55MuAM07dW2xJJNV66itTvr
	 GH0Ltqv4LgQ7A==
Date: Sun, 21 Dec 2025 12:04:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Krzysztof
 Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Heiko
 Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/5] iio: adc: aspeed: Simplify with dev_err_probe
Message-ID: <20251221120413.7f1fa877@jic23-huawei>
In-Reply-To: <20251219-iio-dev-err-probe-v1-1-bd0fbc83c8a0@oss.qualcomm.com>
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
	<20251219-iio-dev-err-probe-v1-1-bd0fbc83c8a0@oss.qualcomm.com>
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

On Fri, 19 Dec 2025 15:31:50 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use dev_err_probe() to make error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Not a comment on this patch as such, but this would benefit from a local
struct device *dev


> ---
>  drivers/iio/adc/aspeed_adc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index bf2bfd6bdc41..1ae45fe90e6c 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -535,11 +535,10 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(data->clk_scaler);
>  
>  	data->rst = devm_reset_control_get_shared(&pdev->dev, NULL);
> -	if (IS_ERR(data->rst)) {
> -		dev_err(&pdev->dev,
> -			"invalid or missing reset controller device tree entry");
> -		return PTR_ERR(data->rst);
> -	}
> +	if (IS_ERR(data->rst))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(data->rst),
> +				     "invalid or missing reset controller device tree entry");
> +
>  	reset_control_deassert(data->rst);
>  
>  	ret = devm_add_action_or_reset(data->dev, aspeed_adc_reset_assert,
> 


