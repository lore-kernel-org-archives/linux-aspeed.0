Return-Path: <linux-aspeed+bounces-5037-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005EFC982FA
	for <linux-aspeed@archiver.kernel.org>; Tue, 22 Sep 2026 12:50:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hq0MP2dvPz2yQJ;
	Tue, 22 Sep 2026 22:50:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790081457;
	cv=none; b=fVvK+JRP0P1zn497MqDhgCUQgjSn/S4OatNaMf46QzYnmFPGx+v8Fnr5VFd/L7dxJ0xz42sY+4rQWddyh4fDEPwSJYFT3S6up9Qvop6OU6UCE8R2ctd4hADw6CpXRMwcS2Icen9uSnWBDBrGqO+9/s0XwxMuoRgUKByhUV2ObtB9rlnjkFSQTiW8kBCkb8/4ayL2fkXAL3Lv5WSJd7w2f4IAzX3SqdNIGggn4g5/LhzKTSta1viK0KU/af0lJkcHmanTMNZitAmRrj6DtIhoZJxSq6pQ16WBUpfRHRB06ur3Tb5fFt11dXxQxmjW+ydVjyZtc028g4C84wr+pOcnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790081457; c=relaxed/relaxed;
	bh=q03pcSGxXBeOQEQK9TaS9voA66lNR23OiFk9hSJIVQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApMTwheuyfOcywYGsgWXIFAVeNFFWztPa3+tRKngPettqphYouI1lg/a/uCRIm5I6Jyfu2j5odi5ChZ5X3PkaPyBPvMaxnQWi/daY0LWubevJ+Xg+LpFPX7ulNDkBgm6q9lzwFjIQTFOMk6DPzCA62iJpIbWx/kzweLyCWA3T04xbCxelgpCW8yhYwerzv730GH2Tl6MzanE3HQO/hpr0tKtHFfIqFM3BoouckZrJ5GUG/8mx5KtzYFw+5JWmWIjVMg2U8xlrJPaoIWzE9FS94rauAYCgH8ZL2r8899ycJV2dO6LgimkF8ROhmyf/XL06Zy184qUAzOFinv9Yr/EJg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=x3Abvig9; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=x3Abvig9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hq0ML2rCyz2yHT
	for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Sep 2026 22:50:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=q03pcSGxXBeOQEQK9TaS9voA66lNR23OiFk9hSJIVQ8=; b=x3Abvig9d7sJvUivUPXDYsKCqK
	hoW1ohDpIZxqlg5HDIib5erf8VoS/iHn8gnn9nWBeEQrT151RrENa+vSIfCuWxrwglgUMAqNJV2w1
	ztrZW7v+yRGwy79jSQ1pMM7tsh83AsxmVmwfr5elJFemVgsoXuaaMvkmYZIEZabLs9Gs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x8zx5-006alj-Mu; Tue, 22 Sep 2026 14:50:27 +0200
Date: Tue, 22 Sep 2026 14:50:27 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com, tan.siewert@9elements.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Message-ID: <1b2b77f5-c10f-4de8-bcaa-aa410f73896e@lunn.ch>
References: <cover.1790079398.git.prasanth.padarthi10@gmail.com>
 <cb05fc2f4158b03d312b94cd9361173fe92ac528.1790079398.git.prasanth.padarthi10@gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb05fc2f4158b03d312b94cd9361173fe92ac528.1790079398.git.prasanth.padarthi10@gmail.com>

> +&mac0 {
> +	nvmem-cells = <&eth0_macaddress>;
> +	nvmem-cell-names = "mac-address";
> +	phy-handle = <&ethphy0>;
> +	phy-mode = "rgmii-id";
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +	pinctrl-names = "default";
> +
> +	status = "okay";
> +};
> +
> +&mdio0 {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy@0 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};
> +};

For these nodes only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

