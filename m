Return-Path: <linux-aspeed+bounces-1006-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3771AC282EC
	for <linux-aspeed@archiver.kernel.org>; Mon, 17 Mar 2025 09:13:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZGTlp6JXKz2ygD;
	Mon, 17 Mar 2025 20:13:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742202790;
	cv=none; b=eoS5O/AuCU58UzYpbcT2v+Un4vqNwMjQAR4Er0HwgrxkkBAjwiERd3sWFQqqpe4FEpe6rG8gnrTMiLD+iTNB9UdAIgUZBXscT4DHj/A3IWZ6KMwKmpUvhSmUJKaLyJKJEE/DtSU/FfJFXVkdCZSm36VBkaT5A3+Hq4+2pDC1OX9IXiWAYHkPxbeC4TGIGE6zLXvtlTbhkenGBa0NNISKv0I0bghCLajaC5KH386JpgmC85k/XnGUk+Upu2O4bl6toBVQkdCu8r/nLYuNFynz4l53JyzxqViOMgriRjzBBKRsCBAxcnRAqIwSm8IH2+IIthG1Hx5MO3NA0EOvLy0Iag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742202790; c=relaxed/relaxed;
	bh=iKOwHKDVPXVA4K4NLTQnzRyUV+R2Qo8xdwTq19z0PqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfv/2+Dvk7y5kF4ZnQyud9XQK8bSaF/6vRgGvMQ4KxRdnFxv36su3u+/GTp7PsuH3dOlR9+W7WkaN1wtgkkaBL+iY5W9ZgRqvWVJ36DO7yyJRt5YbbAQeVvJqhTVVRTgHRRIChPsdCPTBBe8zN27vJcm3NZHSrSKOcOWTfiYFH0CjtjRQH8xJ9s1r9KHWl3p8cizKrVuQAWZXW3HNX5YLzHyPx7jQMA9lkA+7cE0a7xMpbJoaENICGCNi46B8otiKXJp3xB0Q/SrnA6DF0Wl+3MdYPmyMYXNvBwO+G1fnpMOD0Je0LIushNuzgZPmtUa9zr7gybhr6wNmapz9tjcaQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KjKN/zG7; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KjKN/zG7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZGTlp1kmwz2yLB
	for <linux-aspeed@lists.ozlabs.org>; Mon, 17 Mar 2025 20:13:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6FC015C06E4;
	Mon, 17 Mar 2025 09:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED64C4CEE3;
	Mon, 17 Mar 2025 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742202788;
	bh=egUbHhdw/VIJUm8LAkutH+qWohBTh+J4+/zQg3hloi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjKN/zG7AcRdgZCTvQmGNJS/2vUNCY0+Vj973da/zf3skngITlJdC8hKBNeJ2k+TX
	 zzhTEyI04kRxaWNf9LjC0c37o6ZztkmkjIQR+xXdmsTbx99+HC8OdE2vHc5lQODm0g
	 zZs3js/JJAVI6s4zJairySxrmVYks36twqWF9hCzjyviyXzFpJ9Ql4bjlMYM1lp1NS
	 cmvAh5KTGD8vTn/lCAhbgw/0lX+6OkG+MKHJzK7EsvK8DfR8d3UDuyDLwgp64Zd2Hp
	 tNwzcvIjhmguyrmtYXZSBKebeW44t0TMzlu0yLSAb4WXImdFY+tSUXf8VX1ofmtNrH
	 9ER51BCV754Tg==
Date: Mon, 17 Mar 2025 10:13:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
Message-ID: <20250317-chital-of-unusual-force-a4b7b7@krzk-bin>
References: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
 <20250314112113.953238-3-kevin_chen@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314112113.953238-3-kevin_chen@aspeedtech.com>

On Fri, Mar 14, 2025 at 07:21:12PM +0800, Kevin Chen wrote:
> The AST2600 has PCC controller in LPC, placed in LPC node.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index 8ed715bd53aa..f238337e02da 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -626,6 +626,14 @@ lpc_snoop: lpc-snoop@80 {
>  					status = "disabled";
>  				};
>  
> +				lpc_pcc: lpc-pcc@0 {
> +					compatible = "aspeed,ast2600-lpc-pcc";
> +					reg = <0x0 0x140>;
> +					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +					pcc-ports = <0x80>;

So this is 0x80 for entire SoC, then it is implied by compatible, no?

> +					status = "disabled";

Where is any DTS user of this device?

Best regards,
Krzysztof


