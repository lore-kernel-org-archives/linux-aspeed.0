Return-Path: <linux-aspeed+bounces-4333-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1269C43458
	for <linux-aspeed@archiver.kernel.org>; Thu,  2 Jul 2026 17:16:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grk803cDyz2xKh;
	Fri, 03 Jul 2026 03:16:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783012608;
	cv=none; b=EMLGuxH4DlV3OqHOuMK1zeY91khqm42CttYbzLdW789+Beo4yTeyatMENLG9KmcJ9TU674RhPSEQ26DwhaxHG4Kp6AYqn0zCBBPbvDGAACfSDmsEadVPoL3pB2bk3vSn1o9XFJi4OGNUnbnx9LpnZjAXA9tNFkCQeCTi9lCTF6/BXnejBvgotdw3jaf5ES3o4UNWkyrnl0v3wj2/u0A2Wlg8uEnBwv+f0aVyWpSaxRLgFfLm0OhBEaMiF4GCYLGkTmGjrxjcPSwj5BThRSLlO0ctDyozTIDbOJKJdIx4FS1kcRse9uVIjLHeoKnqp6kc/dNjhoAeHb61U1DaJCcdgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783012608; c=relaxed/relaxed;
	bh=9hU8UIsJBJs/wJVPysC5SFtDzxZng9BNNVfogLEp8pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1OqsDGJY/F3tMLOBDbvqeVS4BY4eBZSBmTD1NMevyriInzDM7kfTrAyuAjkHzN5rBUdO2ZV2LKAiYq3TVYim//mqyN73adzwgXIIR8CKLGWwZ53/eDNYDDuQ6lkINYxjQz2xqhpRr9kNa/KVFABoBE9s8BNXuqcBP0RZMJBNzW1H/tC5x24wiZzOreqWmLv2odceZxFN0605EHxPxJW1SqIcA1kY46rpr6FEVONW8fnFefu48beE0FLyfQ0TtT30p4qzka6tiGizTohigLtOKDizDub3VCQ6z7SpaXnXpoMzxmzSQ4eU3Gk/RKElIHF6XVN/iJAd7ZjWjmjtGDHWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=kjpQTX/S; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=kjpQTX/S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grk7y1xjNz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 03:16:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9hU8UIsJBJs/wJVPysC5SFtDzxZng9BNNVfogLEp8pw=; b=kjpQTX/SSMGDFX7PWnu5oH6F0R
	qH26UpJqTO5RPkm0abkr6Kd0jMQplVjnu4Hb4qRiXAEMzNFV3OKWgqJ+/JQMkVpTLWlFq75MQPgdd
	d8xMaN9+t0KnrWLbfp4yQzeRU4879A9J3N17qndTPck/+reBKLKw0WqgPFfpScFnFo/Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wfL1Z-00APGr-Sh; Thu, 02 Jul 2026 19:16:29 +0200
Date: Thu, 2 Jul 2026 19:16:29 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Huang <jackyhuang@nvidia.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
Message-ID: <c43899a8-3d6a-4c94-b0c2-33c00a830610@lunn.ch>
References: <20260702165524.2168091-1-jackyhuang@nvidia.com>
 <20260702165524.2168091-3-jackyhuang@nvidia.com>
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
In-Reply-To: <20260702165524.2168091-3-jackyhuang@nvidia.com>

On Fri, Jul 03, 2026 at 01:55:24AM +0900, Jacky Huang wrote:
> Add the device tree for the Aspeed AST2600 BMC for NVIDIA's Vera
> Rubin NVL compute platform.
> 
> MAC0 uses phy-mode = "rgmii-id" because the on-board PHY supplies
> both RGMII internal delays.  The matching U-Boot device tree does not
> enable SoC-side MAC clock delays, leaving the MAC internal delay at
> zero so the PHY-provided delay is not doubled by the MAC controller.

> +&mac0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +	/*
> +	 * The on-board PHY is strapped to add both RX and TX RGMII
> +	 * internal delays;

No change required, just a comment. The strapping should not
matter. All Linux PHY drivers should configure the PHY based on
phy-mode, replacing the strapping settings. There have been cases
where the strapping is wrong...

>                       declare "rgmii-id" so the MAC does not add
> +	 * additional delay.  The same setting is applied in the
> +	 * matching u-boot DTS to keep early-boot networking working.
> +	 */
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ethphy0>;
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

