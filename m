Return-Path: <linux-aspeed+bounces-145-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F726D6C281
	for <linux-aspeed@archiver.kernel.org>; Tue, 19 Nov 2024 18:20:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XtCV66vqLz2xpm;
	Wed, 20 Nov 2024 05:20:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:45d1:ec00::3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732040446;
	cv=none; b=NnLDEAE+fMJYHzSuaSDK8JslbqayHAqS9Kqz3qj8Ocr8+Krx7xEPOaOBeQ86s1/KVxP5kVxf06OeOv7L6cMlTT9FWtCAVjM1ebQb53/yQibemH1HrX1qU+28sQ2x2kMVYK8ULvECSTCjVbwx/xLajd++Rcxja+H2Hn4c4GUcXkKfu7W5REixEKdjswECDDWWAD6+SJLdkfihXa5O68c7pPLNWTTPLK2KJfK+KWrSJp2n8cUA8JeGJUgM6AzvD0TQ1jFhyk2EXwX2QLLOv5ycVZYM3DA6ai68yK5u7r71kI7HsLyYk4JPkxyvqIQBUwNN4s54uQevf7S1dRXNeCwy3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732040446; c=relaxed/relaxed;
	bh=SsDjHGWgXn8+Qejkkkz91XL7Qc6C+S3k4I/UjMbsnvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJKG6ziUFNhBRagQb/a21RtJy55JpG8ZVdFzkusu8PMQK8OILpXtxQleOnGSN4vPKcch1cowPghDAxZAIXPoiVXNJNGyV/39bkrIzu/lbd5rs5LEI8lwh5QxyO7vwUv6hBrZk2MyMrapY7dLS/qbBtyTU20Ep+qru4Z4G5Fm+u/h1nR9TNU0qRgRCDR4gnfbKOFA3y7d751VDh11AVqWm22OHXit3R7bYvYV/gKkYUKDLonTvPunAmuHScPM97tvECbvUEmiRzJY9KvEcd1r9UtR8ok2xq1vzAYSp8xsA+YLn26RMuEVHMfxF1UU3rMFdq7jCNyt++4IB+3btnXKzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GVokfRuf; dkim-atps=neutral; spf=pass (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=GVokfRuf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3; helo=nyc.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XtCV60c7bz2xnK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 20 Nov 2024 05:20:46 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 515ADA42DC8;
	Tue, 19 Nov 2024 18:18:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE00C4CECF;
	Tue, 19 Nov 2024 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732040443;
	bh=c+7h9hMMGMohgWVCuK5JjLU4dDG65LxAL3SOLXCksaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GVokfRufVjDiWMFrIV55YKvPnfOCikKXfcvMiewwhF33add4VLpqtW2Vw73JsSO6U
	 lG0gVdZtQPV2hEd++iZVLkGGH2ybiE8tTGlQLa3B0Cf5PXekrVqWM4e3HI3D0ISO8k
	 B5dNVHpg6C5CKEDtmFmKP19CRhwsCx4U4f63Q75/WUejr+WA5MrtUjxzotiK3IYDuR
	 EsaZGNjbNghgBAncGOvTEbS7vB0UtIRAN+LJ952CDPNaoLPxDsdEVgpPnyIs02NbL2
	 yZjidGgpE7dl5XTFe9VPst0RAyKogAIP3Xwp9Z00HQmes+vrFF2X6CyJRuxfTWgL7x
	 iBu44xmlHpqFw==
Date: Tue, 19 Nov 2024 12:20:41 -0600
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	hkallweit1@gmail.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next 2/3] net: mdio: aspeed: Add support for AST2700
Message-ID: <20241119182041.GB1962443-robh@kernel.org>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
 <20241118104735.3741749-3-jacky_chou@aspeedtech.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118104735.3741749-3-jacky_chou@aspeedtech.com>

On Mon, Nov 18, 2024 at 06:47:34PM +0800, Jacky Chou wrote:
> The Aspeed 7th generation SoC features three Aspeed MDIO.
> The design of AST2700 MDIO controller is the same as AST2600.
> Therefore, just add AST2700 compatible here.

If they are "the same", you don't need to add the compatible here. You 
still need to add it to the binding, but make ast2600 a fallback 
compatible.

> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  drivers/net/mdio/mdio-aspeed.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-aspeed.c
> index e55be6dc9ae7..4d5a115baf85 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -188,6 +188,7 @@ static void aspeed_mdio_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id aspeed_mdio_of_match[] = {
>  	{ .compatible = "aspeed,ast2600-mdio", },
> +	{ .compatible = "aspeed,ast2700-mdio", },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, aspeed_mdio_of_match);
> -- 
> 2.25.1
> 

