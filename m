Return-Path: <linux-aspeed+bounces-3577-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED47BEB3622
	for <linux-aspeed@archiver.kernel.org>; Mon,  2 Mar 2026 18:05:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fPn061TV8z3bn7;
	Tue, 03 Mar 2026 05:05:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772474710;
	cv=none; b=F8k6YHkeOr7bg5973+V9gr8kW5x5VKtn7HVeiEjdG29+gydDjHSFoYQxFNrTxaYbpOmYinsdD9exUPgEFHbXZPvAOghgJyVXoaWmubaInOdrKyAWqXkqt6CSnuJfEP8spiS9j1kKRHe1yVeNzKXpzo9nghTprNKyh2q6u3SgjVVatdvF10j0RIbUIGXPCeuk3vr3lNTMWxU5Qqfdkmjv+bdGV50OJRxtnx+VPSDQoUrkmpgir5XogsXFIFPDLN0dsHPwSNcxMVOtysAyC9sSzLdb9q1vZItQGkvPcw3FpZjbW6nzPOQtjzB9xsrl0vItlAUrZ53m0ArSqW5tm/AwuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772474710; c=relaxed/relaxed;
	bh=dbpABA9JU9KyaoLnaTdX+Qzh6UTBVghyj5mUgAc/zc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD4X+icAqKsO9uvkB5XmEAyrjIjVvNQoX6Qt1Xk9Ev25iXaEg1pE1b3ydaItigbQZ3DerO3cpcKJia6SDUbM2ek7jPoKFNdg1wEeJw16WppHC/FmQxhlTVaUbHhzNp6sQsVOk0X61OWvlOwOz4x0k7ETxZ2SVQmqt6euDYraIaIdU/fSIMJCGPkzyQjkoTVTqt9BaOPIzU7tJAVtwMbghomr8UdqgJaWravHuEHn2UlWuTvOnnKmggzU65cDqlvbLc2P/mSvujhilTOmHqojHls1KEoav6v3pS9FLlH5xz4qsXzAEVY5YZ1zRH6B7UsXQk+Gsdg5EOALRbi55UjM4w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xgHA13mQ; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=xgHA13mQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fPn0538tdz3bn4
	for <linux-aspeed@lists.ozlabs.org>; Tue, 03 Mar 2026 05:05:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=dbpABA9JU9KyaoLnaTdX+Qzh6UTBVghyj5mUgAc/zc4=; b=xg
	HA13mQZ5O1YbCy2kc/VtLtTftOkFHafr3zOCksEaxiTMZKhZ0CBVcavvjdwQ2U5aUnKkRGAjwuao3
	MWq05P4bkvs5AXWzKkgcRpVXVrnuQbVGWtJUGya9CcZPR6d5lkjNMQFW1PncpSRiUhoEw/WXwuFie
	63ne8jAIS0bMsuA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vx7dO-009ibj-KT; Mon, 02 Mar 2026 19:04:46 +0100
Date: Mon, 2 Mar 2026 19:04:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v6 5/5] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Message-ID: <d38f54b2-4a99-4a54-8403-e4f4a9704386@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-5-68319a4c4110@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260302-rgmii_delay_2600-v6-5-68319a4c4110@aspeedtech.com>

On Mon, Mar 02, 2026 at 06:24:32PM +0800, Jacky Chou wrote:
> This change sets the rx-internal-delay-ps and tx-internal-delay-ps
> properties to control the RGMII signal delay.
> The phy-mode for MAC0–MAC3 is updated to "rgmii-id" to enable TX/RX
> internal delay on the PHY and disable the corresponding delay
> on the MAC.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> index 3f2ca9da0be2..a2a1c1dbb830 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> @@ -123,42 +123,54 @@ ethphy3: ethernet-phy@0 {
>  &mac0 {
>  	status = "okay";
>  
> -	phy-mode = "rgmii-rxid";
> +	phy-mode = "rgmii-id";
>  	phy-handle = <&ethphy0>;
>  
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +
> +	rx-internal-delay-ps = <0>;
> +	tx-internal-delay-ps = <0>;

In the binding, you said these default to 0. So you don't need them.

It is also odd that rgmii-rxid becomes rmgii-id, yet both delays are
0?

What was the bootloader doing? This is worth a comment in the commit
messages.

	Andrew

