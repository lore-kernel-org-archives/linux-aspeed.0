Return-Path: <linux-aspeed+bounces-485-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37321C02183
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Jan 2025 03:06:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YXrVG4xf8z30gv;
	Wed, 15 Jan 2025 14:05:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736910358;
	cv=none; b=AAi4lUuyOGoXMQeYXoZ54h4IxRoKo0+ob8cipR5XQ8YdhKdWcpu1jJSC++KjM/DQT8pQp9YET2kgkJcIVcvwDLISXpoLDN1sgX2Hhf4+4z6XUK/ylgTr7WNLRzEPHUvGazcFe/nyL8iPWhkypsL9dW5VKNe1lG1p4Qh7aQTElLUe4GqQEwSzZKtDSHyYToxyDmAE76xNHIef8JdVca1+aTXbvwHczi+g62kZUpy/2HAvTsXJWBxnl3zokNSHTG0HjEf7Gkt4h5W1/wiwisnARpOx3g39T1++jLggspY2eXioVL2p2HECT7HmsEluVZNZiUNC6/DyspuPuBpuiOyCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736910358; c=relaxed/relaxed;
	bh=xZ3pSeWobvg8Tl71lQfQroV+f3jXMvH5qIsHJ4PQK2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMTrEVAxJpEfeOeWJuiPnqKBN7oQqtfx/AU85VoGQV0ERA7WQiluGfn4qyirKGCNmaMJXOyCZstJ4TsjuHClo48N/vGnmTdXvve/8g+MjPbhHDTfrvmF5P/kzPy3ZaUXR1NV5C9x6Fxa7uIoCD2zwTOHxtPQfffydWLXDE3NRsyMgdXBMo4p+86dpXzk89P0xB2AXF9Tx6eMho4uERKXUicgYxTp8ng1ukUDkRw4uEZzhpQcKiL0yvO/dsMsMKZp+LB49XfsdY4dSIXOtO7kqmF6R1xWpl0XmiZIcF5avLR6eCL+6NRa8FsN8GIVvb29vZWYFFvo956HwfMvW+jRQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=krVR3BV+; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=krVR3BV+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YXrVF0FYgz30P3
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Jan 2025 14:05:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xZ3pSeWobvg8Tl71lQfQroV+f3jXMvH5qIsHJ4PQK2A=; b=krVR3BV+9Rjj3324BmDgxaZ2mg
	hvJQmkiQLPMtvaxTBuqsr6Cbg69R1frvco63GG5G1dyw/jnG65GNG/3pDGQUCxDQteU/UDf3hUIDE
	15MV/GMsuGypwbzxqc/55u7g29U9XYdknbk0RptcwYib0cd5HTzItZPOkx6hKnJmgjAk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXtii-004eNm-6i; Wed, 15 Jan 2025 04:05:28 +0100
Date: Wed, 15 Jan 2025 04:05:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Ninad Palsule <ninad@linux.ibm.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
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
	"openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"ratbert@faraday-tech.com" <ratbert@faraday-tech.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IOWbng==?=
 =?utf-8?B?6KaGOiDlm57opoY6IFtQQVRD?= =?utf-8?Q?H?= v2 05/10] ARM: dts:
 aspeed: system1: Add RGMII support
Message-ID: <e5178acd-0b6f-4580-9892-0cca48b6898a@lunn.ch>
References: <SEYPR06MB51344BA59830265A083469489D132@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <8042c67c-04d3-41c0-9e88-8ce99839f70b@lunn.ch>
 <c0b653ea-3fe0-4bdb-9681-bf4e3ef1364a@linux.ibm.com>
 <c05c0476-c8bd-42f4-81da-7fe96e8e503b@lunn.ch>
 <SEYPR06MB5134A63DBE28AA1305967A0C9D1C2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <d80f5916-4918-4849-bf4e-2ef608ece09d@linux.ibm.com>
 <SEYPR06MB51340579A53502150F67ADEC9D1F2@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <bcebe5ed-6080-4642-b6a5-5007d97fac71@linux.ibm.com>
 <26dec4b7-0c6d-4e8e-9df6-d644191e767f@lunn.ch>
 <SEYPR06MB5134DD6F514225EA8607DC979D192@SEYPR06MB5134.apcprd06.prod.outlook.com>
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
In-Reply-To: <SEYPR06MB5134DD6F514225EA8607DC979D192@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Wed, Jan 15, 2025 at 02:57:04AM +0000, Jacky Chou wrote:
> Hi Andrew and Ninad,
> 
> > >
> > > Thanks. What will be the "phy-mode" value after you make these changes?
> > >
> > > Will it be "rgmii-id" for MAC1..4?
> > 
> > It should be.
> 
> Perhaps we will keep using "rgmii"

No. It is wrong.

> The reason is we cannot be sure all PHYs have support for phy-mode property.
> We will refer to the other MACs and PHYs driver about phy-mode and 
> rx/tx-internal-delay-ps properties how they implement.
> 
> Currently, we will plan to implement RGMII delay in ftgmac100 driver based on
> ethernet-controller.yaml.
> 
> At same time, we will think how to configure these phy-mode "rgmii-rxid", "rgmii-txid" 
> and "rgmii-id in MAC driver.

I already explain how this works once. Please read this thread
again.... The MAC can apply the delays, but it must mask the phy-mode
it passes to the PHY.

	Andrew

