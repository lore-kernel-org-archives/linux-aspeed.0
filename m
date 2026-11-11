Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A25606A324
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 01:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=lJPVZ0ab
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPRKV291jz2xBb;
	Wed, 11 Nov 2026 12:49:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794361790;
	cv=none; b=fw7Ka8eUlxxlIStonNPXDhsd/ABoBIAH9I3cgxTdpkleuplMRqbOlw1DrlDQj02JgyLPULQV0ZbYuWZ9EsI9r1y8s8uKXvUI8gKb0NyS/5SEoSqlNX+qkkjqtH2MFbNOotx2sPCop/HBQhGgktSQIUaWH8BqZgt8ncM31X1bcSWJUOzq5/RHj5ooQbVwqpVAuCJRVQcvSGi8jIuqJj3mJXSr+gAfZY1gwr6iOmD1KVPdRoQFE7niNq8fpIc1AssoEeLk4aMV6GxnTsyr/EIy7OUQamjL56eJQiQZXJalqL2CtkQyLzPj9NB0dvoFAS3EEbNlswCYB/fLVQVeHXzWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794361790; c=relaxed/relaxed;
	bh=7Kmq+KrqsJVdamEglD05VlODQnyHuuKHPdii9uryj5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jPUJ46azrojSG1U2ZvNXauxh2w2QqXotnqLtRj9J5TRtU7AgMQ87B6sYnWSMC6zej/R7FoBQu4E/fqrLy6E+V6mR3qI1esG1uBKOz/oCr5UnhoHke13r8qJC6ujGyKRIM8NxUiCGD8hf3Leav9ABz2Wv7sYqhao5ZdIJzVGr5pi4l/wpjKL5vw+nwaDBd3TBlbHwaCf81JxNpdsBl0k+P+9dqzB7ex49nr6TwUBr59sH9l/GUaM8ou2fGWq/iIy2aFeVHiHRryGB82OFX1LqQeGU8I4Ug8uSg4CH5GomuYr0haTowvYhrkqrqYDlm5UM0NwZWebr6RvGzkngb28zZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=lJPVZ0ab; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=lJPVZ0ab;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPRKS74WWz2xBK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 12:49:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794361788;
	bh=7Kmq+KrqsJVdamEglD05VlODQnyHuuKHPdii9uryj5M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lJPVZ0abKDf0DLzHSxMmK/yrfDVBM1PSNgzEXP3miyBlLjMlmo/se/vVUwfvQwlcL
	 VITk+MFatj7sSRTvURtTFEk0ASGPf6xwTmXgeOYp7cuInxpixCQwF97hyrmsR3/zHU
	 /BHk/NCbxj0MX2USlWM0Gwv3YbLAvPYVpZcDD1o1q3jV83Hcl66r4lMadsuTHhvxul
	 wwpQ1UKXQTrr0znFz/caCwZqbBe196VL/6ak6l2Ob5QjREQC+7Ih4fKKQuG35TWPxZ
	 4nopr6vQijOiHR2A9zc2pjMyBw5FBobqhn5zZPYe4cCgLRiiDpAFpekFTdjzmqFZfW
	 leYmOUgTYQH8g==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 92D0F64C3C;
	Wed, 11 Nov 2026 09:49:47 +0800 (AWST)
Message-ID: <a92395610d27fc0f97af3b27b150de61583c2197.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 2/3] ARM: dts: aspeed: Add Intel AVCRP BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Dawid Glazik <dawid.glazik@linux.intel.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maciej.lawniczak@intel.com, Andrew Lunn <andrew@lunn.ch>
Date: Wed, 11 Nov 2026 12:19:46 +1030
In-Reply-To: <599f1b31-f175-47df-b074-1915688eb390@linux.intel.com>
References: <cover.1794242015.git.dawid.glazik@linux.intel.com>
	 <ee6958ba4b93cde4719fbac89c4027964c2236bc.1794242015.git.dawid.glazik@linux.intel.com>
	 <fff90721f7892c0285f4fed7fed460c7c1e183cb.camel@codeconstruct.com.au>
	 <599f1b31-f175-47df-b074-1915688eb390@linux.intel.com>
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

On Tue, 2026-11-10 at 17:42 +0100, Dawid Glazik wrote:
> On 11/10/2026 6:53 AM, Andrew Jeffery wrote:
> > On Mon, 2026-11-09 at 18:41 +0100, Dawid Glazik wrote:
> > > AVCRP is an Intel x86 server platform equipped with an ASPEED
> > > AST2600 BMC. The BMC is used for out-of-band management, platform
> > > monitoring, and system control.
> >=20
> > It's probably my fault to some degree for not providing a better
> > explanation of what I was after on v4, and for merging changes from
> > others in the past that were pretty lax on the description, but what I
> > was hoping for was something more like e.g:
> >=20
> > - f28674fab34f ("ARM: dts: aspeed: Add NVIDIA MSX4 HPM"), or
> > - bc83b7353d2b ("ARM: dts: aspeed: Add Facebook Anacapa platform")
> >=20
> > Are there more details you can provide? If there are, I'm fine if you
> > reply here with them, and if there are no further concerns I can update
> > the commit message while applying the patches.
> >=20
> > This also applies to the JNCRP patch that follows.
> >=20
> > Andrew
>=20
> Hi Andrew,
>=20
> Thanks, that helps. I also found one more issue in v5 (uart-routing=20
> issue), so I'll send a v6 with the fuller descriptions below
> instead of having you edit them. Please hold off applying v5.
>=20
> AVCRP is an Intel x86 server platform. The BMC is an ASPEED=20
> AST2600-based RunBMC module on the platform's DC-SCM. It supports the
> platform's out-of-band management and exposes board management I/O such=
=20
> as the system UARTs, status LEDs and control buttons, while integrating=
=20
> with the host's telemetry and management infrastructure.

Can you talk more about the division of duties around RunBMC vs DC-SCM?
Can you describe how components of each spec are used in the design?

What's the motivation for designing this module vs using another? Are
there any specific target platforms intended for it? If there are, then
some further details about those would be nice. If not, no problem.

>=20
> JNCRP is an Intel x86 server platform managed by an ASPEED AST2600 BMC.
> The BMC is the platform management controller for the host system and
> supports platform power and reset control, while participating in=20
> out-of-band monitoring and reporting for host faults during bring-up and=
=20
> normal operation.

You don't mention RunBMC/DC-SCM here, so I assume the BMC is integrated
into the platform? Can you describe the purpose of the platform itself
(beyond the purpose of the BMC, which tends to be the same for most
platforms)?

Cheers,

Andrew

