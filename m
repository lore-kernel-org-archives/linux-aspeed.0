Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F66606A32C
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Nov 2026 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=YzOy58HK
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKgj269cfz2xSR;
	Thu, 05 Nov 2026 09:53:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793832822;
	cv=none; b=CmjjP6OO9+UVhlZkoOSzzDIfiCajobOicLboVV9RymF5vVd0WX1H6dtChrIcea9QH9R63MYU/+a3hMkShbm94iyPoyYmHEcluBevBpL7CONdGFva/xkqKNC54HPouYZiG9pQGMgY4p7Xy+COm0WzbuJItcbBpC+PkR3a5M0tDwG7cZwmoqRD5nkPvuJKgPS7vDz5DxJCIoYqTBJYN/KI/1p+n5wqSsqqSi4WHZ3cOqbZT9maG02VftyotkWN8rV57PAAtObkaqpYFG5oREAiEHzSPvPah8wiwoOa7Ut1sS6eUwfGHg0hJYO6v4GwvBsAL4AYIIfu46prdj9u69ZnOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793832822; c=relaxed/relaxed;
	bh=ukB5/tT9mWZkYOa7VV6zjxKWYiggvhMatV2j30aZgEY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eIilDjagJ0D0uL68Wdaj7z89OWGxZnBkRTc4vvS/cVVLEKC5rUPjppPy7VS3rTctDu15dLSyZVHmRA6II/jakWCPjbcjr2JaXMzVun0x9GvK41I64vI2R3d5DdXao5elKLk0HsE70DrV0hDjhQbB7Z5+n6mW2PiGNJSWx30jtm/u0sZ2dmW1jp5ulv95nmoWqT6G/t5CzCtvuWetwDGetTRsrYNR68hTy4THJEMiJuFOiMdi2h3zgxwmwYx7cK/R3JeFNIOw7b7KzpygcjrAGCnSwjcDdMmUO6ExZrfsk++7Yx4qwBVmDLcGqx65EEYGKceyKvNxe9hjEZIoFBulrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=YzOy58HK; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=YzOy58HK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKgj11WQmz2x9N
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 09:53:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793832819;
	bh=ukB5/tT9mWZkYOa7VV6zjxKWYiggvhMatV2j30aZgEY=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=YzOy58HKk9qmK6ynbPSEyojNDhwDWvKsqmHXDAI3hle9mkAuDkg9ZfGOwZxBEVh+t
	 sAEj14EjY2JMNXBH8qYuvJdS5L/j0ZLpYeUVdtDoKbnaTznZ7aqZBQ+dH33QDrNp/C
	 dbQGeXpWQxIG/jrp/GFONgM9YNbNaUBAdoAAvvb5/3UCVjszj9lyNsFL74K8ygAyvo
	 DYWGKTnsuK+cciDz09YEvfCibtQeUedllj8IkzXVMAQJVrMJ8uVkO5BtuQoNDIX0LH
	 U4+xzH04IJDmDNvvhwP2CPnYLZU+8txfToS25qeR4329a92+OKN4xdTQZ1uwzTvp6t
	 2iqz9Jz+jfLtg==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9E24664698;
	Thu,  5 Nov 2026 06:53:37 +0800 (AWST)
Message-ID: <e5222c01c9f0b43758408451cf195e9adc7ef2f0.camel@codeconstruct.com.au>
Subject: Re: (subset) [PATCH] ARM: dts: aspeed: Correct white-space style
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski
	 <krzysztof.kozlowski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 09:23:33 +1030
In-Reply-To: <179380380617.180018.5035897143826922583.b4-ty@b4>
References: <20260801210437.384040-2-krzysztof.kozlowski@oss.qualcomm.com>
	 <179380380617.180018.5035897143826922583.b4-ty@b4>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-04 at 15:50 +0100, Krzysztof Kozlowski wrote:
>=20
> On Sat, 01 Aug 2026 23:04:38 +0200, Krzysztof Kozlowski wrote:
> > Correct a few white-space issues, like missing space before bracket
> > '{'
> > character or spurious space, which will be flagged by dt-check-
> > style
> > ("redundant-whitespace" warning).=C2=A0 No functional changes.
>=20
> This is waiting for three months without feedback, so just picked it
> up.

Thanks. Apologies for the not getting to it. I've struggled to find
time for upstream kernel work of late.

Andrew

