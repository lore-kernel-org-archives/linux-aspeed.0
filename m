Return-Path: <linux-aspeed+bounces-368-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07346E77188
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 17:53:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSwW14D7Qz2yRD;
	Thu,  9 Jan 2025 04:53:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736358781;
	cv=none; b=W6hvNLqD3f7SRHDIQb5LcrIx9Qc4zaoCSgCQlDUm0vRXdZSOx2HZEWO5zilbO2RkROqML9ghMF/NDwF5FhVfuwmGxJdkdxy+N5NICdhZlmWaj/WpgfN5cRdjYaw0Sezkukf9o78aTj4gsqFDhbO1CHGHGLvz+E1FtIJiMNY6eWMiP4el6txgJDu7OVtJso/DWPesdE5AZwEMJ03I7Ko74v3l54NRZjO4ePdCNKjnoqhBJgSmvTzXRDl0F3yC8Rp3XtJP5/eI1ngmM8AgYPkVQogY9ownwX7jWj7l09BKkP5dFluC/n7vXRp4G6v3NghNMK+vmIEcZ9OvY31Jpi5sKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736358781; c=relaxed/relaxed;
	bh=TAAO1Chf6hDYV9mEVdFl4KLhPTl2u2J4AKlDsKfF4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo3wPjtMpbwGDy9656TcMB8JYWNa11HKMyAYsLP/EO3nvk7rWeaxvnbvL1M58i7jVdoNcapkCUmYuIde8S1QXv8zufb1gMdpx28lPa6Xl2kG7peXIAGc55cgQVTtSHbiuXRli2DPBBTHLiMNbPHZ9B9GciGg/oQ4gb18zhSGZrBD8G3B/ZVrMHCmxu1TLqZLYQTin4Yq6fMCE7xqk6g70qzmsviGd/oU3ZXbgo5bLXPB4AazWhjDxTYnzX45QyAaJLBYrfxfR9b10SSVyoSTF4IKdF7dQ5q9KebkahkWsDYpePpL+t6BrHs8xm8StiInOMddK68nddue1d9yHkZ3WQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=XtQQjt1u; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=XtQQjt1u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSwW03Jn4z2y8X
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 04:53:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TAAO1Chf6hDYV9mEVdFl4KLhPTl2u2J4AKlDsKfF4qk=; b=XtQQjt1um6jDIVerxn2G5x/9Yg
	VigbPTw+BhyEl8UPKACYGGkerBa4/lPUaT3YGcbKd1+qBorH4cqWZMhxVgKqR4ZhTRpgw3i8Ktlw5
	JCZJm55al/ky1Nbj3aK19x4uKztA8k/2F/fRu2z/UXlopcvNLhwaJkYa0mH4b/1CWbno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVaEW-002e68-6T; Wed, 08 Jan 2025 18:52:44 +0100
Date: Wed, 8 Jan 2025 18:52:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"andrew@codeconstruct.com.au" <andrew@codeconstruct.com.au>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"eajames@linux.ibm.com" <eajames@linux.ibm.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"joel@jms.id.au" <joel@jms.id.au>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"minyard@acm.org" <minyard@acm.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"ninad@linux.ibm.com" <ninad@linux.ibm.com>,
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: [PATCH v2 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <0c42bbd8-c09d-407b-8400-d69a82f7b248@lunn.ch>
References: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134CC0EBA73420A4B394A009D122@SEYPR06MB5134.apcprd06.prod.outlook.com>

> >Does the mac0 TX clock have an extra long clock line on the PCB?
> >
> >Does the mac1 TX and RX clocks have extra long clock lines on the PCB?
> >
> >Anything but rgmii-id is in most cases wrong, so you need a really
> >good explanation why you need to use something else. Something that
> >shows you understand what is going on, and why what you have is
> >correct.
> 
> Here I'll add some explanation.
> 
> In our design, we hope the TX and RX RGMII delay are configured by our MAC side.
> We can control the TX/RX RGMII delay on MAC step by step, it is not a setting to delay to 2 ns.
> We are not sure the all target PHYs are support for RX internal delay.
> 
> But ast2600 MAC1/2 delay cell cannot cover range to 2 ns, MAC 3/4 can do that.
> Therefore, when using ast2600 MAC1/2, please enable the RX internal delay on the PHY side 
> to make up for the part we cannot cover.
> 
> Summarize our design and we recommend.
> AST2600 MAC1/2: rgmii-rxid
> (RGMII with internal RX delay provided by the PHY, the MAC should not add an RX delay in this 
> case)
> AST2600 MAC3/4: rgmii
> (RX and TX delays are added by the MAC when required)
> 
> rgmii and rgmii-rxid are referred from ethernet-controller.yaml file.

O.K, so you have the meaning of phy-mode wrong. phy-mode effectively
described the PCB. Does the PCB implement the 2ns delay via extra long
clock lines or not. If the PCB has long clock lines, phy-mode is
'rgmii'. If the PCB does not have long clock lines, 'rgmii-id' is
used, meaning either the MAC or the PHY needs to add the delays.

The MAC driver is the one that reads the phy-mode from the DT, and
then it decides what to do. 95% of linux MAC drivers simply pass it
direct to the PHY. If the phy-mode is 'rgmii', the PHY does nothing,
because the PCB has added the delays. If it is rgmii-id, it adds
delays in both directions. This works, because nearly very RGMII PHY
on the market does support RGMII delays.

There is however a very small number of MAC drivers which do things
differently. Renesas produced an RDK with a PHY which could not do
delays in the PHY, and so were forced to do the delays in the
MAC. Please look at how the ravb driver works. If the PCB does not add
the delays, rmgii-id, the MAC driver adds the delays. It then masks
the phy-mode it passes to of_phy_connect() back to 'rgmii', so that
the PHY does not add any delays. If the PCB did add the delays,
'rgmii', the MAC driver does not add delays, and it passed rgmii to
the PHY driver, and it also does not add delays.

So, your MAC driver is broken. It is not correctly handling the
phy-mode. First question is, how many boards are there in mainline
which have broken phy-modes. If this is the first board, we can fix
the MAC driver. If there are already boards in mainline we have to be
much more careful when fixing this, so as not to regress boards which
are already merged.

Humm, interesting. Looking at ftgmac100.c, i don't see where you
configure the RGMII delays in the MAC?

	  Andrew


