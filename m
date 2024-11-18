Return-Path: <linux-aspeed+bounces-136-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED584D60CFA
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 Nov 2024 23:00:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xsjlf27rJz2yT0;
	Tue, 19 Nov 2024 10:00:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731970846;
	cv=none; b=Kr4+YFbn5/ob+2gBLWk9zcESNRxWv1z+AUvY3ioTKNe/1JA6pUHe7UyeX54EouW15w8c8CAMer3cU/wcpUSnbVNchPcOX/gFPqfQEhXGYSGyLGdFFQIdCny0sd9LrtIRcN2T08LsL8jzeHRA5GjjGxDbySVgWjYYFAilRZWk3eRI6oVkEMgS/WjVwL4tbcjBiFnoulbHASdaQJtD75Pp1sdZXM7J3Sus2AQtvbIb0NdYOj2bcEhE/vHPOeLQfRpAdXbEidhvd+p+G6fYOjxPx74s/o7q4GZb9dnnTYyWzqVW3r8hcZXfeHvhf2lOAsCFRZmyZ6LJljvVdHFerm5UEA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731970846; c=relaxed/relaxed;
	bh=CW49FFGZM5+j6JkPSwK06UkPkZUwSK4a4tgqhadqsvo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iWJ4iByDxE20KjWsiEpi+oQGa3mt+G/y83dw6nQq5R5DUiSVKGg+LTfRPDcxsDVEh+5mQIf13A4JRAG/2+AXndOGfxT3MAuSRKwbaWjegX0imlaydddJZwvH8VuecCcMIHgCd5iSuvP+PNtxIjh12Y2Wq5FP+uhr19FkP9RzlP9iHaWissG3eKfv1pBZt613gGqwfqO+s12pzmV1rAjkFUI2kKo/g42KueQ5IZgGnjcOgPIlxOpIABMoIsYdbuMFj9M7SO9M69+YDo03fectz27AtMH9gsvea7FMjfZgD5jZwbtS4Gl09ihzA122AEiLLpNJtpffFpdbphvGbmeYBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=AWsAMyOL; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=AWsAMyOL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xsjlb5zgHz2y92
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 Nov 2024 10:00:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731970843;
	bh=CW49FFGZM5+j6JkPSwK06UkPkZUwSK4a4tgqhadqsvo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AWsAMyOL4ww5MLzWMdBiuoq16eacUcwGCB4EJfGlASqLw5onf1XZWjU+TSR+5r65A
	 L21wiDtUH0+4JAPb9Q7n2JyMCIz/hFjXmJkP2nhGzaWdWwpCL7TUcfgxsw3N+EDEO7
	 wJIsEoTTuEGXwN4pYPNvAyjvC2UKkBGNqwZFLO53LPHr5XMQLjleBX/07sokLdZ9+L
	 f/NBKIGuudfF7EBws2c1vynq3F+R+dZwuxa8LUTeqtp9B+CtOPXqotfB93PYj/Ffwz
	 37upcwgVHFz+BNypFFIVp1Tcg99Nlbo/6EyDwcZ9R4jLOrZ1DvL6724bflFzplUFf9
	 P8B4cBUlUquRw==
Received: from [192.168.68.112] (ppp118-210-181-13.adl-adc-lon-bras34.tpg.internode.on.net [118.210.181.13])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3AC8F68D9B;
	Tue, 19 Nov 2024 07:00:40 +0800 (AWST)
Message-ID: <219607ab74764f3d47659fb5ab3223b3034152e5.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/3] watchdog: aspeed: Update bootstatus handling
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Guenter Roeck <linux@roeck-us.net>, Chin-Ting Kuo
	 <chin-ting_kuo@aspeedtech.com>, Patrick Williams <patrick@stwcx.xyz>, 
	"wim@linux-watchdog.org"
	 <wim@linux-watchdog.org>
Cc: "joel@jms.id.au" <joel@jms.id.au>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org"
 <linux-watchdog@vger.kernel.org>, "Peter.Yin@quantatw.com"
 <Peter.Yin@quantatw.com>, "Patrick_NC_Lin@wiwynn.com"
 <Patrick_NC_Lin@wiwynn.com>, "Bonnie_Lo@wiwynn.com" <Bonnie_Lo@wiwynn.com>,
  "DELPHINE_CHIU@wiwynn.com" <DELPHINE_CHIU@wiwynn.com>, BMC-SW
 <BMC-SW@aspeedtech.com>,  "chnguyen@amperecomputing.com"
 <chnguyen@amperecomputing.com>
Date: Tue, 19 Nov 2024 09:30:39 +1030
In-Reply-To: <2531f830-6a36-4bd5-ba1e-9e19f0f66496@roeck-us.net>
References: <20241101121201.2464091-1-chin-ting_kuo@aspeedtech.com>
	 <20241101121201.2464091-2-chin-ting_kuo@aspeedtech.com>
	 <ZyUcIIb1dtoNhX00@heinlein.vulture-banana.ts.net>
	 <a0faca9a6ec7f4acdfa2f29b4ffb94b5392aea6b.camel@codeconstruct.com.au>
	 <TYZPR06MB5203053A004676F51322DECFB25C2@TYZPR06MB5203.apcprd06.prod.outlook.com>
	 <ed77d57facaaef0be796b4c6a742dc7bf3bff479.camel@codeconstruct.com.au>
	 <TYZPR06MB52039B02B6D3053355F30489B25D2@TYZPR06MB5203.apcprd06.prod.outlook.com>
	 <9a1e64ef-81d9-48b0-b871-ce4ff792eae4@roeck-us.net>
	 <TYZPR06MB52039DB39B62E6FA5220103AB2272@TYZPR06MB5203.apcprd06.prod.outlook.com>
	 <2531f830-6a36-4bd5-ba1e-9e19f0f66496@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Mon, 2024-11-18 at 12:50 -0800, Guenter Roeck wrote:
> On 11/18/24 04:46, Chin-Ting Kuo wrote:
> > Hi Guenter,
> >=20
> > Thanks for the reply.
> >=20
> > > -----Original Message-----
> > > From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter
> > > Roeck
> > > Sent: Friday, November 8, 2024 10:08 PM
> > > Subject: Re: [PATCH v4 1/3] watchdog: aspeed: Update bootstatus
> > > handling
> > >=20
> > > On 11/7/24 21:42, Chin-Ting Kuo wrote:
> > >=20
> > > > But now, I think it will be better to add a patch for creating
> > > > a new
> > > > reset reason, e.g., WDIOF_REBOOT or WDIOF_RESTART, in
> > > > watchdog.h of
> > > > uapi. Can I include this change, creating a new reset reason,
> > > > in this
> > > > patch series? Or, should I create an extra new patch series for
> > > > this
> > > > purpose?
> > > >=20
> > >=20
> > > This is a UAPI change. That is a major change. It needs to be
> > > discussed
> > > separately, on its own, and can not be sneaked in like this.
> > >=20
> >=20
> > Agree. However, how to trigger this discussion? Can I just send a
> > new
> > patch separately with only this UAPI modification? This is the
> > first time
> > I change such common source code.
> >=20
>=20
> Yes. That needs to include arguments explaining why this specific new
> flag
> even adds value. I for my part don't immediately see that value.

So maybe I was derailed with my WDIOF_REBOOT suggestion by the proposal
to repurpose WDIOF_EXTERN1 to indicate a regular reboot. I still don't
think repurposing WDIOF_EXTERN1 is the right direction. But, perhaps
the thing to do for a regular reboot is to not set any reason flags at
all? It just depends on whether we're wanting to separate a cold boot
from a reboot (as they _may_ behave differently on Aspeed hardware), as
on a cold boot we wouldn't set any reason flags either.

Andrew

