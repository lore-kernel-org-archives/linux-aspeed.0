Return-Path: <linux-aspeed+bounces-3596-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F21FF3092C
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Mar 2026 13:16:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRVS04Pv6z3c5f;
	Fri, 06 Mar 2026 00:16:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772716608;
	cv=none; b=MxUJ9/ulreTcOnMab38mGWoJeAEmXliZLx7tDvkZX/OEnJG8njeWRbndN2u9ctfZ44Bo3Y8l4Zb4WipGmJCnW0To7Pu3szI6UZLczy8bPyPzQuGwi9O/8CTy2rtZu6cGNKk08VxhjAkuSMwq8cds/x5+zMLF8bTzbmHFeypgK/gljo3FXxIzlDMNfi5CtFRIOf1iP7nrFErTmmdUw0s/rZDJ64n29oMTAYnfY1SNmS0HofhXiK9fDLVA0iXkXgDpnJQpScCea/8wMlmw5adxGNje7mDvcCdBC3huJtI0z49Tmb6M6eBvglnZENQfU24s60C49VFKPbo1cIQDh3Hhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772716608; c=relaxed/relaxed;
	bh=12ucEdAFXfC6E20WpVMMZDujwQClNo1zj9TEZw+WEZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kemuwN79dfAO72uRQ713yc2UHqdvRtLfDzv2Y+3mYonf9UOw3p5SCIVddSVi1CgYZUC5D9+P5WIgZ/FaWoy0G6px/hPsVLhf+wCH94D9sKtCeQiRrdNm0rnq3b3ktbr6PgxAwsIMDRTYgfAXCeKwdsG4Al7BPRQT8LbqA2qPWSiOP1edMh865+dfxLUwkZwwUa5u/Xe9vdO0m4HPK81qmh9TNXuNGI0Ig/7mebUqUFUeYBT/W3igp0Ux4DZIMCZxA0ZGobUSr1wQwh2NMvkncuFrlc/AQ55MgJfio9mgMkcIXYnvkeMKiYhqHKzNVk7mbSrqVdZVkWIQrI4ycrLkow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Z7PFjdGz; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Z7PFjdGz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRVRz1j74z30MZ
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Mar 2026 00:16:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=12ucEdAFXfC6E20WpVMMZDujwQClNo1zj9TEZw+WEZQ=; b=Z7
	PFjdGzuNOxxgbi7rXc+QGGG1TooRwb7XHvOaOXpw/tlJOv5pAlEHE2vg3AYFGI6cK4gtTWDmL9vwV
	nr6rLbxAy3vyUsp42wOSZxCl6aUVnPdzotD8P/pf3Bk2t2+fzfVA9Mlnpw35GsxeCvAA9HXCd3cAi
	HRL5I4pGs2tstA8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vy8Yl-00AJih-0P; Thu, 05 Mar 2026 14:16:11 +0100
Date: Thu, 5 Mar 2026 14:16:10 +0100
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
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"taoren@meta.com" <taoren@meta.com>
Subject: Re: [PATCH net-next v6 5/5] ARM: dts: aspeed: ast2600-evb: Configure
 RGMII delay for MAC
Message-ID: <70ed84fd-ac9d-4157-ad20-36deec0c5f82@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
 <20260302-rgmii_delay_2600-v6-5-68319a4c4110@aspeedtech.com>
 <d38f54b2-4a99-4a54-8403-e4f4a9704386@lunn.ch>
 <SEYPR06MB5134AE0B0042E05E8E58A5239D7DA@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134AE0B0042E05E8E58A5239D7DA@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Thu, Mar 05, 2026 at 05:05:03AM +0000, Jacky Chou wrote:
> Hi Andrew,
> 
> Thank you for yor reply.
> 
> > On Mon, Mar 02, 2026 at 06:24:32PM +0800, Jacky Chou wrote:
> > > This change sets the rx-internal-delay-ps and tx-internal-delay-ps
> > > properties to control the RGMII signal delay.
> > > The phy-mode for MAC0–MAC3 is updated to "rgmii-id" to enable TX/RX
> > > internal delay on the PHY and disable the corresponding delay on the
> > > MAC.
> > >
> > > Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> > > ---
> > >  arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts | 20
> > > ++++++++++++++++----
> > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> > > b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> > > index 3f2ca9da0be2..a2a1c1dbb830 100644
> > > --- a/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> > > +++ b/arch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts
> > > @@ -123,42 +123,54 @@ ethphy3: ethernet-phy@0 {
> > >  &mac0 {
> > >  	status = "okay";
> > >
> > > -	phy-mode = "rgmii-rxid";
> > > +	phy-mode = "rgmii-id";
> > >  	phy-handle = <&ethphy0>;
> > >
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&pinctrl_rgmii1_default>;
> > > +
> > > +	rx-internal-delay-ps = <0>;
> > > +	tx-internal-delay-ps = <0>;
> > 
> > In the binding, you said these default to 0. So you don't need them.
> > 
> > It is also odd that rgmii-rxid becomes rmgii-id, yet both delays are 0?
> > 
> > What was the bootloader doing? This is worth a comment in the commit
> > messages.
> > 
> 
> Before this patch, aspeed-ast2600-evb.dts is an existed old dts in mainline kernel.
> In this series, ftgmac100 for AST2600 will configure the MAC RGMII internal delay
> via SCU register, so this patch is changing this dts as a NEW dts for driver to configure
> RGMII delay from the properties of MAC nodes.
> 
> Old dts: generally, leak tx/rx-internal-delay-ps -> Calculate the RGMII delay that is configured
> from bootloader and decide whether keep the original value
> 
> New dts: In AST2600, we expect the MAC node includes the rx/tx-internal-delay-ns properties
> and the driver directly uses these properties to configure RGMII delay.

You did not answer my question...

> It is also odd that rgmii-rxid becomes rmgii-id, yet both delays are 0?

I could understand "rgmii" becoming "rgmii-id" with both delays being
0. But that is not what you have here. It is starting as
"rgmii-rxid". So the PHY is being asked to insert the RX delay, but
not the TX delay. Where is the TX delay coming from?

I assume the MAC? Has the bootloader configured the MAC to insert the
TX delay? But look at all the board vendors who have been submitting
DT patches, and i've been rejecting them. They all seem to use rgmii,
not rgmii-rxid.

Why is this different to all the other boards? This is what i would
like to see in the commit message, an explanation of this oddness.

> We hope this series can keep the old dts works fine

Hope is not sufficient. Backwards compatibility is required. You need
to convince the reviewer the code changes are backwards
compatible. You can use the commit messages and comments in the code
to explain how backwards compatibility is maintained, while adding
this new functionality.

And once you have convinced me, i will probably ask you to post the
changes to the BMC mailing list, and ask for a few board vendors to
test the patches with old DT blobs, current DT blobs and updated DT
blobs.

And this is why i think fixing the issue in the bootloader is
better. It is much easier to convince a reviewer the changes are
backwards compatible.

	Andrew

