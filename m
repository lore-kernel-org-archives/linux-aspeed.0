Return-Path: <linux-aspeed+bounces-4157-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDCCCD6E60
	for <linux-aspeed@archiver.kernel.org>; Tue,  2 Jun 2026 17:00:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVHBZ2XCDz2yFK;
	Wed, 03 Jun 2026 03:00:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780419606;
	cv=none; b=k2N7lv4yku2g9NwML9HASGRTKksMPmRKY9Dbf5YWgUsp+v9K7v0B2ttllSwMThur6zoJgkPrKtwtuMa8rrrT2mvjh4roSP3LzSWa6OgjGnw3xFXPCvl66bS5ZXZYsTSSOxdQyTvohOMGCmdpvSQudiXVViE7JGhCVkMiMDldJI6GNGJZhtFz1IOmpFu/dI/i26amvxbHBadGf2nQzuu+kBfO4163/njwtyzRia05XehPhUaEAQKRf8GGB2jVYdeo9oe63oZp8WTL14TY0oAX90tQwNtge8SL59oV1jIGTWz1Ktd2wfFvOKYwW3DNw0RyNtY1QI6TMXGulLePVJG3zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780419606; c=relaxed/relaxed;
	bh=aXEL4pwfPMVz7iJb43Gvy4V5PhxsUFD/gCBxQEtwy8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KByYdRVIUGn8c/tKRisv1pIJFZZWJ1KS75dHturE4gEJCrm4XI1OhvIDKtlySNw4nb+i9vDa5HU6MOXkENryMN2ef8DE+mzy5w7ZsA3/WJUJfR+XzGrbGvTvm9Ld7JrDSq2uYQud968AtO0w2pHDk+RTBleA9v3On+g3KOD7WSTv+1EJye+56SEaqIeT0SnfyXlVZXDeYK1hrHBm5GAh5+MGUxtM4zNBqS60au6teKyFtg92TpPRfcWwne0+G9+0r1/vREP1a7iS4O+rPsZD/4/R0b6svpFU0FaAEieeijBooiUTNzImoifbqv6pSgYtrfQJ4DOxw8JRt8hn5q8Dkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqn5sFCk; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eqn5sFCk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=conor@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVHBY32djz2xKh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Jun 2026 03:00:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C24246001A;
	Tue,  2 Jun 2026 17:00:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A6B1F00893;
	Tue,  2 Jun 2026 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780419602;
	bh=aXEL4pwfPMVz7iJb43Gvy4V5PhxsUFD/gCBxQEtwy8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eqn5sFCk9Gvk5MQ7a/oBBQ1+0KnpNVzVsNgERJHir3cW8slvMQ+h7DfI5X3owfXWD
	 yaoVqBHOnyep+/kld0J65qgMHBPo8MxXdXBzXcRPgP0f666v/1lXt2hemMLszNKK5o
	 bSOqyunDtFpKXL9T3vZwPHr3zV4+T7wiXsDr5DQeeubDFYlxh9zAr5ICEhwEMI5CGP
	 RstELcE6izDm6itOOogAcqL766P6clMh5X/O6NnSaUrnTKdGK3dYR20jtq5Zu4Pa44
	 eDr1YobTBhfQ/QCxqw4JxlpO0VvDONJv11f8L0FzBTdeeRGcF9zkckWecb/xveAOgz
	 tGNlOtjyzw7zw==
Date: Tue, 2 Jun 2026 17:59:57 +0100
From: Conor Dooley <conor@kernel.org>
To: Tommy Huang <tommy_huang@aspeedtech.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH 1/2] dt-bindings: rtc: add ASPEED AST2700 compatible
Message-ID: <20260602-refresh-crawling-e6852feb9dcb@spud>
References: <20260601-ast2700-rtc-v1-0-15d4ca46500a@aspeedtech.com>
 <20260601-ast2700-rtc-v1-1-15d4ca46500a@aspeedtech.com>
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sSlNZiJes0XynWvQ"
Content-Disposition: inline
In-Reply-To: <20260601-ast2700-rtc-v1-1-15d4ca46500a@aspeedtech.com>


--sSlNZiJes0XynWvQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--sSlNZiJes0XynWvQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCah8MDQAKCRB4tDGHoIJi
0srpAQC+gmj4JJGrXIWGVt27womZpP49QqQ/L1k3k5X9ws77DAEAt4Hn4w2ksqmf
SI39dQOHYZ0+bCvn00VuAoOoxWr/Bww=
=kyAk
-----END PGP SIGNATURE-----

--sSlNZiJes0XynWvQ--

