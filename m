Return-Path: <linux-aspeed+bounces-3286-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD99C9EC7B
	for <linux-aspeed@archiver.kernel.org>; Mon, 12 Jan 2026 11:47:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dqVxN6ms2z3050;
	Mon, 12 Jan 2026 22:47:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768218472;
	cv=none; b=XnpBq75GH/NK25VdcSeyOqhVLRz9FkDM+OdCpK4ROAkYq/oXgiMb+mT1ZUuCt+74yOMlJtGz8ZSdTdjSjZfkTWw1lBelc8N7wPkiTxLB1UOl3DF/fLX/tMXe9TdN53K2oLQIaejR/7XTnUUP/Utp/n1sN3/SP4dm21V1L1GD+0PEFtZE9O2Sgznt1TVGF6avyCsLwXiZDuRxB5h6f+DWVLp1V1QdtFMl+ZLrZ8W3wA1sFPV6Uwr//E+HlX+1mcJIrF7cZ76ZYmvRWUhhs9TS6tRmxp+HdHWAdwGgswnW5/r/JD2rdXc/6koa2GTs8butOc1KSkcwnYuxV2RMvTCqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768218472; c=relaxed/relaxed;
	bh=/4S2ffhUScYe1oalT7XXK9u5A6GaoEljjZjRU+VMDxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHd+Q+rIQZeUWg4aM794HmwRSpg9sxWoPPdznYNtxWIoiea44MsEH+cL/Mgt0t7+PB0GJmsnEH25rbHoSpog7IHWTc7n2GDfKIszsm+/OXs6WAohYUPJKNDCWNBCaGK0tbu1Xar3BRlWAMZfqbus+OHHVZqO6WXS3TETdRh4iVr9wDmTur3odjk3SEcYJq/mRF0Mwecrv6yI/FVqEMM42KUrsA4fXnfSvo3VCwZJAAydA8BSO1sP1ND0NepwWvHEN2thYkWDUp3L22wzbKqbfkvB0CIUgtr672vaNjRN58N4+MjJX1tlkrHOM2D89JkjCyixIACO1mX6Qvmy4IGUqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ov0GMxKt; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ov0GMxKt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dqVxN25w2z2ynn
	for <linux-aspeed@lists.ozlabs.org>; Mon, 12 Jan 2026 22:47:52 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 474396001D;
	Mon, 12 Jan 2026 11:47:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7095AC16AAE;
	Mon, 12 Jan 2026 11:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768218439;
	bh=/4S2ffhUScYe1oalT7XXK9u5A6GaoEljjZjRU+VMDxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ov0GMxKtj6Y4+sxQolquMOuCwO7oaWxw44KyaJs4xFm75xPKzFOctgkFbOcUM/0JN
	 Ry/H7xWWRSJbf+RwNKiEMrJ8SF7IJla970kNNe9+urBUYj8p51knfh/j6dRJLly9y7
	 r6FZAIWHup8GEU+ReniBNQ7CLLTrnR91w7+gh1QaWUJTqGksssDvMsuEcOEVI1pY5x
	 sHZB4IibalOo0ok63dZjENzq0/FZ9ga+9ywzs2C9fiwOLdubLnScm8oNmua4jR/WlG
	 gRteS7LzQgfSWhQ3QngqReZcJsWBAF+KOh04pNXdCHdhTl31H8IDLjpsYiBKFl63PZ
	 HQ/oW/wAfA2EA==
Date: Mon, 12 Jan 2026 12:47:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Anirudh Srinivasan <anirudhsriniv@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: Add Asus IPMI card
Message-ID: <20260112-whimsical-annoying-fulmar-25e4d9@quoll>
References: <20260111201040.162880-1-anirudhsriniv@gmail.com>
 <20260111201040.162880-2-anirudhsriniv@gmail.com>
 <45bdf2a6c0d33dd6ce0fd3cc279ef6edc509a540.camel@codeconstruct.com.au>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <45bdf2a6c0d33dd6ce0fd3cc279ef6edc509a540.camel@codeconstruct.com.au>

On Mon, Jan 12, 2026 at 12:01:27PM +1030, Andrew Jeffery wrote:
> On Sun, 2026-01-11 at 14:10 -0600, Anirudh Srinivasan wrote:
> > Document the new comptaibles for Asus IPMI card
> >=20
> > Signed-off-by: Anirudh Srinivasan <anirudhsriniv@gmail.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b=
/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > index 9298c1a75dd1..b2d20341f8eb 100644
> > --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> > @@ -79,6 +79,7 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - ampere,mtmitchell-bmc
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - aspeed,ast2600-evb
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - aspeed,ast2600-evb-a1
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - asus,ipmi-card-bmc
>=20
> It's a bit bike-sheddy, however: the pattern tends to be
> ${vendor},${platform}-bmc, but as the platform can't be specified and
> the card's function is the BMC itself, I'd go with "asus,ipmi-
> expansion-card" (I couldn't immediately find a useful identifier other
> than the product name).

This should include some model name or at least soc. What if you have
IPMI card for ast2600 and later completely different for ast2700?

Best regards,
Krzysztof


