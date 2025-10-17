Return-Path: <linux-aspeed+bounces-2488-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56204CCD195
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 06:22:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnvrJ5NNJz2yqh;
	Fri, 17 Oct 2025 17:22:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760682160;
	cv=none; b=GXyl6PmUPsjZnxmB5PehUltNDw8Q64GdkpM01Zuve86RO8vbl+MNkjJkct/WPpTLkttMn7vDMADLVUXyovk6LGnF1Uqaq7iXUCMqJga/FaqehbAjvRCmmMvNYgXpQ8REjB9v99TrxOspygB8a4v18KpE4QJRirht+HOz4XhOtHoV29p1f5IRdnCpovpRFlLDG9dFg7HMfTdENh16ZdHy0dQ/rRXNrEZVChLqnw3haok7W8BbtZrGAvEXr3XPj8ifWnBthY6qAc+tOoVxUasg4E6xEJNWE6T5jJrFda2OM2S0mpmrJM9mEk0vltiX9ZOf9cpcg9BvGP8RpqQEVjIc+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760682160; c=relaxed/relaxed;
	bh=ECOUsH1noeAgZRtyf60EKc9L4f4Ba1khmYrgNO6yCKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HvdKqEulWXDIu0I/IEoxeQO1DGhF1b227zV5oFkTUDhguoBh+vFamYoOCfDO+Q0jfePwz53GX/TY38+5+xVsvvuMLn/oXpXqclaeI47BNHvZi6kFCJdWotCLuONlH0YvDV0TRgSd3JNlggytnUdNcJvUh2hIqjcSle7i1kjV03icZyRs2UyHWiUUTsOG5a+Zj21AuigLas+CHtkgR+0IZ1vSGeXCdu9Bteyua5gq23UcUrz6nG6EGH+iTFrikTIr+uYzfgTygSxSd3/OLsBizWRc1fZ1xFF2fvdtsFsVZwBNrNrF/85MK6Qd63t1ctgkt+QYGjGcwyFSSMoRiu4IMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hvLneN0/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hvLneN0/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnvrJ1VdMz2xQ0;
	Fri, 17 Oct 2025 17:22:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760682159;
	bh=ECOUsH1noeAgZRtyf60EKc9L4f4Ba1khmYrgNO6yCKI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hvLneN0/Px7YzZp8b/zEB/xqh4Q/3+FDAw7zlSsc4TeURYycGuPdfKTZ3AnO7n/e0
	 dhUJwk5jSVHBT5GDP00eYJSTeCx1s03MhFSu8gi1YqapD10A3v9X4qqLrAAjfvRAuy
	 BA/l/adLjPGmTQp/adoDUvyk1LN2XrKbc9KwnxIpsExPKG+Iq5DN16jA3jB6Rp1NiO
	 18K5D1Ukc3IIEOUsC8W8YSr78oGfK8XoDXz7eJKZiyv3iS8KveEisQFKdE+bXfCKZE
	 2WNy9vSuS+0oONiu+wxcoFIxwrwQyxJfVavPLlBbEFpoS5zT5TEKTvrIFQfIWZUPXo
	 /VJuozz3Mh/ug==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 73D1B6477A;
	Fri, 17 Oct 2025 14:22:38 +0800 (AWST)
Message-ID: <ba2e6b78e59afb7c89e5022770a142ec8c31659a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] peci: controller: peci-aspeed: convert from
 round_rate() to determine_rate()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brian Masney <bmasney@redhat.com>, Iwona Winiarska
	 <iwona.winiarska@intel.com>, Joel Stanley <joel@jms.id.au>, Maxime Ripard
	 <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	linux-clk@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 17 Oct 2025 16:52:37 +1030
In-Reply-To: <aPEZSY6RC-UVclxN@redhat.com>
References: <20250810-peci-round-rate-v1-1-ec96d216a455@redhat.com>
	 <aMatZAX6eFI1RmDH@redhat.com>
	 <28dc3bd8aeca7e3164747960747f75060c596704.camel@codeconstruct.com.au>
	 <aPEZSY6RC-UVclxN@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

Hi Greg,

On Thu, 2025-10-16 at 12:11 -0400, Brian Masney wrote:
> Hi Andrew and Iwona,
>=20
> On Mon, Sep 15, 2025 at 02:36:48PM +0930, Andrew Jeffery wrote:
> > Hi Brian,
> >=20
> > On Sun, 2025-09-14 at 07:56 -0400, Brian Masney wrote:
> > > Hi Iwona, Joel, and Andrew,
> > >=20
> > > On Sun, Aug 10, 2025 at 06:21:51PM -0400, Brian Masney wrote:
> > > > The round_rate() clk ops is deprecated, so migrate this driver from
> > > > round_rate() to determine_rate() using the Coccinelle semantic patc=
h
> > > > appended to the "under-the-cut" portion of the patch.
> > > >=20
> > > > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > >=20
> > > Would it be possible to get this picked up for v6.18? I'd like to rem=
ove
> > > this API from drivers/clk in v6.19.
> >=20
> > My (strong) preference is that Iwona applies it, but I'll keep an eye
> > out for any unusual delays.
>=20
> This patch wasn't picked up for v6.18. Any chance this can get picked up
> now for v6.19?
>=20
> I'm hoping to get this merged so that we can remove the round_rate() clk
> op from the clk core. The clk maintainer (Stephen) mentioned this work
> in his last pull to Linus.
>=20
> https://lore.kernel.org/linux-clk/20251007051720.11386-1-sboyd@kernel.org=
/

Are you happy to pick this up directly in Iwona's absence?

Andrew

