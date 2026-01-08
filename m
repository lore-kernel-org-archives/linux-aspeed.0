Return-Path: <linux-aspeed+bounces-3256-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B9BD1489D
	for <linux-aspeed@archiver.kernel.org>; Thu,  8 Jan 2026 05:16:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmtRj2QmBz2yG3;
	Thu, 08 Jan 2026 16:16:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767849393;
	cv=none; b=gfCAc899fAPfzzrw9VRQxuJESXC+eKmAR7fpjSqu1XSjq6saixLvJWSPV0gJ9Gm6OhwJNRx6HaR7aIxea24Vk2e6HiTnMYZWk7VOr8M0ncfWAdfUwj6a+dLu1U6Hw7nS7PCDv0LV15gnZgVns7KEfde75+TSaqFns7zV2+9gI2owVL14fJeRm2/DXYPdUrTLjMVXsi1W4SSmLWpWiyizpPJH12R9ABjLtuXNjo6u5QkJVyunQ8Jwvpocbl3fkt7rczkEFdDqxR+Z0otqQ5RooF8GzggFP8vEgixKU41vmOzU8dAHLSEdQItUJCypgYLYPt7X0nrlgeDVde868KRsYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767849393; c=relaxed/relaxed;
	bh=xbN0xXbu2Yat5/DqybzT3Ivmx4aLPskHLX3kZsD1fb8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Isoe0VnEZqL97dCQgJI65n6ZurF/LzCOOuXvwutHlqC9XN7Q5xuEHHUFb5mXwX6l5feKNYkaS/DBCdBaHdy0rKlKGXR23qo0UnoMnccRwYBYpByjSmQQJxmtTNcGXdbjv6SLpKQGRhNcQGeyf25Qc6h5BFvP8T7+gZJpMNKuqVtbsJeO8Pc/hT50ob2E9gimT+od/kNABvgfM6Zz6f3T1Jkd71zjvWeyvwe7ihmmfIdqGNInLz/sdmZGFel5iiQWD0nTkAh0A17xxA1dDqsG/waexq+iFD5MN0Nb3KsUwnE0yG/Wy3VbOhMJ4599YG2aP28wLaACmi0DHuFq9NNwhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=F5jtziWg; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=F5jtziWg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmtRh5FbNz2yF1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 08 Jan 2026 16:16:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767849392;
	bh=xbN0xXbu2Yat5/DqybzT3Ivmx4aLPskHLX3kZsD1fb8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F5jtziWg0rSiH6DROhn/PXN89zytE/z+yPwV0oPFfKgUnQ3SHMUHptKi9LCijrQ17
	 fXYlztKVDmcVJDg6Jqz5xLfx8BxKRYJzXRhrYnzFCeEv3luTHqU4DrqhrA0WzOAWwS
	 gx8p7/Ugn3QYSHLyak6VwjP0D1cmljeJDSQ9mt47l+lsWxowNVtl9gtZ9orjCpvRdJ
	 7S/+LewZzqJaAKOC1ogBKet4GO4jqOIH+Fg5u8Su0lZTZtCOMmUdwAdUvr1ZLfb6Ze
	 5QLEXLXt84t8SzFzf+Rs9PjzMRLzitkIjj70KTvByBB5IQ8kO2GegLAipzti9yB3Dj
	 qlD/Ebq2AhQgg==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 888CD79F8C;
	Thu,  8 Jan 2026 13:16:31 +0800 (AWST)
Message-ID: <a9e75f46a69e86c2d555065f251b9ece3050827e.camel@codeconstruct.com.au>
Subject: Re: [PATCH v9 1/2] dt-bindings: arm: aspeed: Add compatible for
 Facebook Anacapa BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Shen <sjg168@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 peter.shen@amd.com, 	colin.huang2@amd.com, KKrzysztof Kozlowski
 <krzk@kernel.org>
Date: Thu, 08 Jan 2026 15:46:31 +1030
In-Reply-To: <20251219091632.1598603-2-sjg168@gmail.com>
References: <20251219091632.1598603-1-sjg168@gmail.com>
	 <20251219091632.1598603-2-sjg168@gmail.com>
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
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0

Hi Peter,

On Fri, 2025-12-19 at 17:16 +0800, Peter Shen wrote:
> This patch adds the compatible string for the Facebook Anacapa BMC
> which uses an Aspeed AST2600 SoC. This is required before adding
> the board's device tree source file.
>=20
> Signed-off-by: Peter Shen <sjg168@gmail.com>
> Acked-by: KKrzysztof Kozlowski <krzk@kernel.org>

I've fixed up this tag and the misspelling of Krzysztof's name along
with it while applying the series.

It's important that you actually insert the tag provided[1] and not
invent some other one.

Please fix your workflow so this isn't a problem in the future.

I suggest using b4 (and `b4 trailers --update`) if you're not already:

https://b4.docs.kernel.org/

Andrew

[1]: https://lore.kernel.org/linux-aspeed/259e917f-0570-40d6-983f-bfe9d7744=
4a7@kernel.org/

