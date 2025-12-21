Return-Path: <linux-aspeed+bounces-3188-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA500E67482
	for <linux-aspeed@archiver.kernel.org>; Sun, 21 Dec 2025 12:04:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dZ0M96TvQz2yFQ;
	Sun, 21 Dec 2025 23:04:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766318693;
	cv=none; b=S1RtdeO/hK1ac8wlYlQnfVLLVE+lcB5n+RVq1YCH8Df6Hi54/G1ixLzKRLQRaNtmKx410wuy1dLtHESlSXDXB8V1Q/A3y0cgCtyVnQaRFWk9/L9KRwYnYFFC7Jijbmza0zfpPuZjplaFqzMW0ONJMkp2D3st1Xk30Owf48FDfQQgd+G0l2O/8CbF6M8WfdzrQx0RNCgtNdfTr4zTytGcEhTnhryfHY9a+VgdgSXSq6CaSCdrcxVy3RYcz6+guU2XQ6o8FlIGXqEuVwWvztxfDvx5N2EadKHoE9+MVXLBjUiGRQu0ZW8JkmMqcB9fo8fFT2TaLGJMhlRnOHEbvVuPGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766318693; c=relaxed/relaxed;
	bh=thuT7JPzP6ijGee2PwFI/Fkh7CU0FprxFiOeg3tcdUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMuW6SWDcwA3RvGzzUti2IZXmg3hKmjqv+YHT5xNMpHrEmHr7z3svA7+Khh3gJrArD/9h/vk976GJmlt7rjtrzpQAThj6/E5vQAQe3E6OcCjSTw7siTecDIWG/CSKvEhY5nkb9yikg8JuMYm6xj5JVBppoCqLCC3rxIMiBwRfsIcdID1yzrKUaXVLc3CTljAis5ivLeoAZV/ChdkZay3CIYrH+tkVDVZV0g1I0QHzYvm9cvjWu9OSIxfVdQjng5aMCxc576OMGAYMi/4SkRsFJYsUJpGzI26Ewf7xMLv+sesicEq4qVbtKfFLz9XDcZBbUFl5n7oyn6ouO+ymaeC/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oqDNeUcy; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oqDNeUcy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dZ0M86CTmz2xQB
	for <linux-aspeed@lists.ozlabs.org>; Sun, 21 Dec 2025 23:04:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3FD3942B10;
	Sun, 21 Dec 2025 12:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B2BC4CEFB;
	Sun, 21 Dec 2025 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766318690;
	bh=7LVQ8OFSH90aBTKeJHbT6h52O5X5Gibty3PLGF89PDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oqDNeUcywridYkQcEhbD4MFn2rDVLVbge9+UENfHQXADzdMeBATSju97wySENj2Pz
	 d+tUuRRLIJykix21Wv9ZJG0k4s53SmnsutnxtFtp0VFZIs5vft8m2o/J1L5aEvtaOF
	 aFA5GwrQ6lJTn3IS1Top2ShQDW/vlOEBj+NbCfUDh9HUhPwrlkU346ODM9jUH4+sXx
	 6jt72+9OwPTJh3U4HXnoQvVIFc27XFg8FaOeG1A5s9L3t+2fR6KVzhYlVTA+fz/Zkc
	 /tGUuMTQf8qyeR4Jbar9BIkUSnemwSK+KZxq6Dj4Z1zc9YfGxCL7wvZNh8yb+MWc7m
	 p8kgIzemsGaAA==
Date: Sun, 21 Dec 2025 12:04:39 +0000
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
Subject: Re: [PATCH 0/5] iio: adc: Simplify with dev_err_probe
Message-ID: <20251221120439.3aa841ca@jic23-huawei>
In-Reply-To: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
References: <20251219-iio-dev-err-probe-v1-0-bd0fbc83c8a0@oss.qualcomm.com>
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

On Fri, 19 Dec 2025 15:31:49 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Use dev_err_probe() to make error code handling simpler and handle
> deferred probe nicely (avoid spamming logs).
> 
> Best regards,
> Krzysztof
Thanks. Series applied.

Jonathan

> 
> ---
> Krzysztof Kozlowski (5):
>       iio: adc: aspeed: Simplify with dev_err_probe
>       iio: adc: exynos: Simplify with dev_err_probe
>       iio: adc: qcom-spmi-rradc: Simplify with dev_err_probe
>       iio: adc: rockchip: Simplify with dev_err_probe
>       iio: adc: sc27xx: Simplify with dev_err_probe
> 
>  drivers/iio/adc/aspeed_adc.c      |  9 ++++---
>  drivers/iio/adc/exynos_adc.c      | 29 ++++++++---------------
>  drivers/iio/adc/qcom-spmi-rradc.c | 20 ++++++----------
>  drivers/iio/adc/rockchip_saradc.c | 13 ++++-------
>  drivers/iio/adc/sc27xx_adc.c      | 49 ++++++++++++++-------------------------
>  5 files changed, 43 insertions(+), 77 deletions(-)
> ---
> base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
> change-id: 20251219-iio-dev-err-probe-59b3104c8d4b
> 
> Best regards,


