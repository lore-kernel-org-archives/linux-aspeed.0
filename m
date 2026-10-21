Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D385606A323
	for <linux-aspeed@archiver.kernel.org>; Wed, 21 Oct 2026 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRf6zhza
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j8ynf0zRYz2xSD;
	Thu, 22 Oct 2026 05:42:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792608150;
	cv=none; b=jVZ3rW6M4FX3ZaL3EgTNsJ7sgBbSurRLu1Ll0v6dPZeNmuvbyyirLFjqEBmLG/Yhjr1J0jhqG6LVLFB3Qe1iV95h/SNbWMbOxNqfqT+yLaXHfDtFJK9BMBqaEsAX48wot0BlFpAty7RbxlIRK5M0b0CwDaM4DrLwVsnyp7UDFc5yF0BjXZI+vu+cFx5RO+btbvrmuejfTDgMBwTOcTsxkAMTqAsLSMaZyLzuEfYTqVfElUuEi9vij6YE639T+OkfCBmI1ryWCNWEasdQX1G87nanW9NoXLCK0IgvQtSCRRrMbsTegwiGqHPUcfH9a3d6V0YZN/MvAcRMl6BVNjTcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792608150; c=relaxed/relaxed;
	bh=SJBXnCQJmXKfHRqXv0OES81MaO/XzIb/4ZDkwzt1z98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oeh1dcMSdc/l1SpaSvYXzhOsJME/gjkziSb5uSCZzhxuKjrDdrJ0ozo82J0mmXvXm0ACuTSU2UrZO1XdaDB/KqF0WWDNErhqFJsQ+VHRmQeYLilzf+8pkwjoSlFUwX24xQw1Fj9WvqEEJ55RowafjSroLhohJ06ng4OxTnQE6DT5MO8n1Yo5fqPYbFJXUygY5NbdLQlj/9T9d642/H9pvC7T0MATYW7Es3VuBz0aDnhloqBuUYqE/uTEImNJDJ8YV1lJiRRGE2HnzvQH6FNPwVqAa6uXtNbb3mfUSqRjY+Y6PfrkIufz0PYfz8Fq0TXQTyIjq3c90SAW7jaUbK6FWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRf6zhza; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRf6zhza;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j8ynd1TpMz2xPW
	for <linux-aspeed@lists.ozlabs.org>; Thu, 22 Oct 2026 05:42:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id EC6EC60052;
	Wed, 21 Oct 2026 18:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531141F000C1;
	Wed, 21 Oct 2026 18:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792608145;
	bh=SJBXnCQJmXKfHRqXv0OES81MaO/XzIb/4ZDkwzt1z98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IRf6zhzaBqHO3dtATHN8jDUEiKza6xOoSdneJiKwDzuEuhFxajEV3K0M+KttkC7VY
	 P2Vs6sO9IcS7YzgjiJGIN4l5JZvZlmuNsEFy+ISkbTJAaQGfzqh3OAz+6ZO74m+LbX
	 +6o6YKwsgTwlwNfow8W4UdS2SX17JEvXItBRldJ9rgZOlTXj+FESFez9zDS4FMbvGI
	 8Pdf75sOhbLA7QAyniXUJOn3JJNnKur6QLzsfevlumdhbxpurTgocu1YN69CaFGAtz
	 zvq2KNTgxvzJjrDgsNf8sbZt+xVvTQKJcoxBgBHGqaa/26Fr+cQfysA9dNnD5kFkIy
	 5ZHBxLPdSMAcg==
Date: Wed, 21 Oct 2026 19:42:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: =?UTF-8?B?5Zue6KaGOg==?= [PATCH v3 0/3] iio: adc: aspeed: Fix
 SCU lookup for multi-SCU AST2700
Message-ID: <20261021194216.034f348d@jic23-hlaptop>
In-Reply-To: <OSQPR06MB7252FB0EB1DCD1069E11CEF18B662@OSQPR06MB7252.apcprd06.prod.outlook.com>
References: <20261005-ast27xx-adc-upstream-v3-0-ef25552d3a59@aspeedtech.com>
	<20261018235624.1971e7ff@jic23-hlaptop>
	<OSQPR06MB7252FB0EB1DCD1069E11CEF18B662@OSQPR06MB7252.apcprd06.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 01:51:53 +0000
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> > > The ADC's reference-voltage trimming data lives in a SCU register. The
> > > driver has always located that SCU with a global, name-based
> > > device-tree search, which works as long as a platform only has a
> > > single node named "syscon". AST2700 splits its SCU into two
> > > instances, syscon0 and syscon1, that share that same node name and
> > > differ only by label and unit address, so the lookup always resolves
> > > to syscon0 even when the ADC's trimming data lives in syscon1.  
> 
> > For now I've applied 1 and 2 to the testing branch of iio.git.
> > Whilst it is a fix, there is little point in rushing it unless
> > patch 3 also goes and that one isn't tagged as a fix..  
> 
> > If you want me to move it over to the fixes-togreg branch and
> > get it in asap, then reply to this to say so.  
> 
> Patches 1 and 2 only add the mechanism; they don't change behaviour on
> AST2700 by themselves. The driver falls back to the old global
> by-name syscon lookup whenever the new "aspeed,trim-syscon" property
> is absent, and patch 3 is what actually sets that property on
> AST2700's dts. Without patch 3, 1 and 2 land but AST2700 keeps reading
> the wrong SCU exactly as before.
> 
> So yes, please move 1 and 2 to fixes-togreg, and I'd like patch 3 to
> go with them. I'll resend it on its own with a Fixes tag pointing at
> the commit that added these ADC nodes, since it's the piece that
> makes the fix actually take effect on hardware.
> 
Done and marked those two patches for stable. 



> Thanks
> Billy Tsai

