Return-Path: <linux-aspeed+bounces-2494-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37995CCD195
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 07:43:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnxdh5f10z2yMh;
	Fri, 17 Oct 2025 18:43:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760687016;
	cv=none; b=fVmxL40ESZl+tlBNXJH92Tc7d1oGYQRwEUsbMaSloCj41JD3noRNA1sCkWSu60kcNwcpWuKd5b5oYyztOoTImy4L2lmHLfzXTDAwOfQAMhEijrWBzhUsfJinrHcHGDSe4Sy58OCgDh6TK2F8s4VSB+1ENZbspg/0P3501TLXON40z6BLOG+CCFSjl27wO7c2goj8mSS3p1KxXOS3hWIOLw9uvUuXhJUD9uwpp0TQk/gxZaP9+R9xjq+z0v+76dPBthuo/yU7amx7h9agHEavH8Gs1vlLQGLGqkXdKsl1V2ICBs0ApLGmeHZY/FLfy87LSe/jx8g6ZXKB3HpA90qtcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760687016; c=relaxed/relaxed;
	bh=XQrvP1GlmV9hF254YFykYp7sZklQgP8zUBpeNxqA/go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8a488HJRgFXROqOMTmGzguh64Pw6qneZ71khcTFJw9ihpzwe+bFzGv/IZXy//wUCmogwTwTMDlREimg7cGDxF3GnixK+oiPYaAJpxGSjzYWljcE9L6ynJLxQhqxnq54bfYbCZ3Oka4y3KvRRDQPGaq48e9kE7tk+uaEWnhSVnTWqJCknIdb8Bnedq1rSKA/dnmbx5XT5Aos05reiaDod3Wdw0oiz67QiG9NyB0SRAPg6PE+93TX/U1DzeeOgx3aiJB6PaWLPGDDpCijSZa1+abUUTx3OI+nbiGpsSJZm2seZI0F9XVfw/lia7uo2ZOsPlZnfO9sqU6NuRgwmGInqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rbgnTyiR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=rbgnTyiR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnxdf2rbZz2xcB;
	Fri, 17 Oct 2025 18:43:33 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AE04C6036C;
	Fri, 17 Oct 2025 07:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3942C4CEE7;
	Fri, 17 Oct 2025 07:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760687011;
	bh=Ghawdb9l72IEZCfQwNVJ0wErDbWEow5FhFKT+ciucco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbgnTyiRwNqzWTCsT9SFJ0M0y6ewfizs6HV6j9R9MCeXDn5I+PfLLTbX7sIZzLKdb
	 2CLT0UiaisCdgatT2tsNx53BuVw1axilp0cVSfN3oo61y9gcRgaA5AbPgN6rFvEW+K
	 y3LwXgi9MYsbutny94X7lRDSlaUPH76FX4X3wTQI=
Date: Fri, 17 Oct 2025 09:43:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Brian Masney <bmasney@redhat.com>,
	Iwona Winiarska <iwona.winiarska@intel.com>,
	Joel Stanley <joel@jms.id.au>, Maxime Ripard <mripard@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from round_rate()
 to determine_rate()
Message-ID: <2025101721-twiddling-huskiness-4852@gregkh>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
 <aMatZAX6eFI1RmDH@redhat.com>
 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
 <aPEZSY6RC-UVclxN@redhat.com>
 <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
 <2025101759-runner-landing-374b@gregkh>
 <2975918e3f3a7de245e93fbee52335acb78bb23a.camel@codeconstruct.com.au>
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
In-Reply-To: <2975918e3f3a7de245e93fbee52335acb78bb23a.camel@codeconstruct.com.au>

On Fri, Oct 17, 2025 at 05:57:44PM +1030, Andrew Jeffery wrote:
> On Fri, 2025-10-17 at 08:41 +0200, Greg Kroah-Hartman wrote:
> > On Fri, Oct 17, 2025 at 04:52:37PM +1030, Andrew Jeffery wrote:
> > > Hi Greg,
> > > 
> > > On Thu, 2025-10-16 at 12:11 -0400, Brian Masney wrote:
> > > > Hi Andrew and Iwona,
> > > > 
> > > > On Mon, Sep 15, 2025 at 02:36:48PM +0930, Andrew Jeffery wrote:
> > > > > Hi Brian,
> > > > > 
> > > > > On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> > > > > > Hi Iwona, Joel, and Andrew,
> > > > > > 
> > > > > > On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> > > > > > > The round_rate() clk ops is deprecated, so migrate this
> > > > > > > driver from
> > > > > > > round_rate() to determine_rate() using the Coccinelle
> > > > > > > semantic patch
> > > > > > > appended to the "under-the-cut" portion of the patch.
> > > > > > > 
> > > > > > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > > > > > 
> > > > > > Would it be possible to get this picked up for v6.18? I'd
> > > > > > like to remove
> > > > > > this API from drivers/clk in v6.19.
> > > > > 
> > > > > My (strong) preference is that Iwona applies it, but I'll keep
> > > > > an eye
> > > > > out for any unusual delays.
> > > > 
> > > > This patch wasn't picked up for v6.18. Any chance this can get
> > > > picked up
> > > > now for v6.19?
> > > > 
> > > > I'm hoping to get this merged so that we can remove the
> > > > round_rate() clk
> > > > op from the clk core. The clk maintainer (Stephen) mentioned this
> > > > work
> > > > in his last pull to Linus.
> > > > 
> > > > https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org/
> > > 
> > > Are you happy to pick this up directly in Iwona's absence?
> > 
> > Why me?
> 
> I figured that would be sensible since Iwona historically sent you PRs
> for the PECI subsystem.

I did not remember that, sorry.  The MAINTAINERS file does not mention
this at all, and it lists many other maintainers that should be able to
take this patch:
	$ ./scripts/get_maintainer.pl  drivers/peci/controller/peci-aspeed.c
	Iwona Winiarska <iwona.winiarska@intel.com> (maintainer:ASPEED PECI CONTROLLER)
	Joel Stanley <joel@jms.id.au> (maintainer:ARM/ASPEED MACHINE SUPPORT)
	Andrew Jeffery <andrew@codeconstruct.com.au> (maintainer:ARM/ASPEED MACHINE SUPPORT)
	linux-aspeed@lists.ozlabs.org (moderated list:ASPEED PECI CONTROLLER)
	openbmc@lists.ozlabs.org (moderated list:ASPEED PECI CONTROLLER)
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED MACHINE SUPPORT)
	linux-kernel@vger.kernel.org (open list)
	ASPEED PECI CONTROLLER status: Supported
	PECI SUBSYSTEM status: Supported
	ARM/ASPEED MACHINE SUPPORT status: Supported

thanks,

greg k-h

