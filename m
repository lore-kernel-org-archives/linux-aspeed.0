Return-Path: <linux-aspeed+bounces-371-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 475A0E77188
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 20:14:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSzfF6GTrz30Tr;
	Thu,  9 Jan 2025 07:14:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736367269;
	cv=none; b=fGvvZAr2VDVQae1a00VxiLFzR9z5ZyTQdE1Xq4LYOTJBrDDDnfrtCgsiSRUMgpKMOvgQjD/JkGlYCuMdcdS8fhtFN44V8W134YJS5k8BmDj/CIk4cTuJex0VG/l3CWhgfM3zH6gn+0TAuc/2G58Rr3u2/yhhIlcprGSztG73ZwV1ScuDO0GeJpoiXzw3C+Q7G/dYsmbo2lhHvDADvLMDjvcbAk+siK/LMb+bejUcW4N2Yo38jAfsRmsfl1E39uqeH8WdqgM4XbyfOAwNFEpiST5ICWHQGAuAQo5J7FJqaDOSQKb3P/801clqrASrKT5w4JSGH+h8IBdqF/liyDBh8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736367269; c=relaxed/relaxed;
	bh=hs8uP3N/mTdsE3JF6EEgjMUW9ubX3QrUliIYU0W1Efw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgctVJbzyC3JUJbJI/dBtUTbRcMV2pUpUtl/y3//duxL6hTt4IvAMjhx6Sml8rB6Z7cr7GvmcFMqYfGxAVsbQNeECViXhzvFpczM15zU5DFZWnfN/yOfeK3xBy4/3n9U+1fvlSkkd7IJ5TmR6G+ZE/WecTzljSkWx1oGj8aR8kBecgSM3ICjRyCjchushx1H4U/FALQ4Tk4MAKFuCoJiCI+UqTXAipPCJTy/i5jpKwHVTTg6491OYsL33SvZySESYSivJuu8PwdZJ8oNl0vbOhLrnlemBx3+p63wnPD8PPkzGfuCAERVsgjO2VvWWlI1LjjV/kbgDFESh+TSccSx7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=cokaGl5r; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=cokaGl5r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSzfD39rFz30Tc
	for <linux-aspeed@lists.ozlabs.org>; Thu,  9 Jan 2025 07:14:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hs8uP3N/mTdsE3JF6EEgjMUW9ubX3QrUliIYU0W1Efw=; b=cokaGl5rbCCWR5PLEEXlzlK4cg
	61kIh8CGC74Kzu7whTHy6mmGZiSShEsvkL/AiJ79CgmLhcin6x2cZmY33bJNEFJBTn2rnElphfZ8A
	QoBXD8JA3+CWcAR2AKXIabgI7RguloybklWjZ7s0SMDRD9wP03I3Y1lpAgkiPSW+xw0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tVcR0-002fvx-Ne; Wed, 08 Jan 2025 21:13:46 +0100
Date: Wed, 8 Jan 2025 21:13:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: minyard@acm.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ratbert@faraday-tech.com, openipmi-developer@lists.sourceforge.net,
	netdev@vger.kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, eajames@linux.ibm.com,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] ARM: dts: aspeed: system1: Add RGMII support
Message-ID: <b80b9224-d428-4ad9-a30d-40e2d30be654@lunn.ch>
References: <20250108163640.1374680-1-ninad@linux.ibm.com>
 <20250108163640.1374680-6-ninad@linux.ibm.com>
 <1dd0165b-22ff-4354-bfcb-85027e787830@lunn.ch>
 <0aaa13de-2282-4ea3-a11b-4edefb7d6dd3@linux.ibm.com>
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
In-Reply-To: <0aaa13de-2282-4ea3-a11b-4edefb7d6dd3@linux.ibm.com>

On Wed, Jan 08, 2025 at 12:43:07PM -0600, Ninad Palsule wrote:
> Hello Andrew,
> 
> 
> On 1/8/25 11:03, Andrew Lunn wrote:
> > On Wed, Jan 08, 2025 at 10:36:33AM -0600, Ninad Palsule wrote:
> > > system1 has 2 transceiver connected through the RGMII interfaces. Added
> > > device tree entry to enable RGMII support.
> > > 
> > > ASPEED AST2600 documentation recommends using 'rgmii-rxid' as a
> > > 'phy-mode' for mac0 and mac1 to enable the RX interface delay from the
> > > PHY chip.
> > You appear to if ignored my comment. Please don't do that. If you have
> > no idea about RGMII delays, please say so, so i can help you debug
> > what is wrong.
> > 
> > NACK
> 
> I think there is a misunderstanding. I did not ignore your comment. I have
> contacted ASPEED and asked them to respond. I think Jacky from Aspeed
> replied to your mail.

You did not mention in the cover letter, or the patch. I asked for a
detailed explanation in the commit message why it is correct, which
you did not do.

Now we have more details, it is clear Ethernet support for this board
needs to wait until we figure out how to fix the MAC driver. Please
either wait with this patchset until that is done, or drop this one
patch for the moment and submit it later once the MAC driver is fixed.

      Andrew


