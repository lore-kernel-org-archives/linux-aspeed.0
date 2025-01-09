Return-Path: <linux-aspeed+bounces-379-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93424E77197
	for <linux-aspeed@archiver.kernel.org>; Thu,  9 Jan 2025 11:29:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YTMyZ1P0mz30gL;
	Thu,  9 Jan 2025 22:29:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736422198;
	cv=none; b=JbBbhaw4nkx2T/qm73EuEv9PVcb4ga4Gi41dyKcHCWbsY48ecFStPpG9YMUQByBJue0iRWjxPvsrISd8WJprx4+26iQ0qTMUXZcQb0/8Y9YtSt6QlQP6CFEi07Gh85c/R1Zcd+UnSu7FL6EbVY35CGmNDVA8+m4WCy3I5ICLlJ3k5u1TscjpVrR10EQryKL9IcV5SYE6pCb8cm6ZVyJJNRntKoQw8NFj0KO7ftfpXLSsR2G7252LJZpOVWRNg/aDjNqyxFTlM0BI2t1xb0qbHO7CgYqInNBZqDFZgqtZcp/nUiNmSe8uyjsnfZLP4+0OYYfnmwI2aGiKfsB7Se3aAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736422198; c=relaxed/relaxed;
	bh=1I13lWmYyz3lcb7t1Bm62ddpGsn+ruZJv5ADU7rxo7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PJIzUpzwYeCaNyt1pNnZ8YDDvukL1pAVKjqkVVgy0XU6uPr/l70ln/Rn9/m2g3O77ttB0x2/uVkxF5gHYKL7EsSgNihxQJ5HdsAax7XB5DHvXUK8+NemLkXAZVDFCYi2HxpzGSerpimqBZ/TVBrbFLFsSvx6r/kZi7uSYygVT9h5eXUAD3ccvmygVVU6jKUHgHRY2DgvgljAtXEzFjDgUCvICi/bnvfnwcSpSzzRRmhFMweFyAbS96v7xUbcq5dnA2c8c2n8uhHk/C9wSWvQaQkcHi++ue6XOFnDlzpwVlloNgsc3gSrs8SkLSwruza3eD/Xco8qbp/I2SHoQwi5pQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=collabora.com; dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=iWroFgmD; dkim-atps=neutral; spf=pass (client-ip=148.251.105.195; helo=bali.collaboradmins.com; envelope-from=angelogioacchino.delregno@collabora.com; receiver=lists.ozlabs.org) smtp.mailfrom=collabora.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=iWroFgmD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=collabora.com (client-ip=148.251.105.195; helo=bali.collaboradmins.com; envelope-from=angelogioacchino.delregno@collabora.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 601 seconds by postgrey-1.37 at boromir; Thu, 09 Jan 2025 22:29:56 AEDT
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YTMyX5ZS6z2yVd
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 22:29:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1736421588;
	bh=MYB0yAjxoyhbDi50XtUpsGNrWVikNTnxxJs1VA0CsbI=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iWroFgmDaUTpLUd/8EIbk7IAg3CIGCAnaZsv3NRCD2+VrnXKIHLbosH5aqXEeg/V4
	 yNHSOKSWXGqYFCCWhbMN0eZxPnY5zChZnn0zqfM3+IATOdJtsZizNWaQ4n39DTvm99
	 /CJd9kPdfpxcl21X70waImqyrCXSNCqU2Wo0nam5Lfde3eVl5K8+oGZkGcctX+Pwej
	 ndy+AF9omDIwmBdKM3UBdV6kjg6pMpUaMbUeLte6MN8VzlrV3ChckLSvjfKLNjyrHn
	 sdmVt41fdGmTLwovY5X6D5TxKeVN//bqIgE9QRKqV0u55jZtEhSqh2sEv/o3LnbXiE
	 MqyM3xsDLnwFg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E98C317E1569;
	Thu,  9 Jan 2025 12:19:46 +0100 (CET)
Message-ID: <1e442fd4-1361-40d5-a152-adb16704a982@collabora.com>
Date: Thu, 9 Jan 2025 12:19:46 +0100
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
Subject: Re: [PATCH] dt-bindings: usb: Correct indentation and style in DTS
 example
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Justin Chen <justin.chen@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Benjamin Bara <benjamin.bara@skidata.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
 Tianping Fang <tianping.fang@mediatek.com>,
 Jassi Brar <jaswinder.singh@linaro.org>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
References: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/01/25 14:10, Krzysztof Kozlowski ha scritto:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

For iTE IT5205:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



