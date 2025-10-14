Return-Path: <linux-aspeed+bounces-2443-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B18CCD18E
	for <linux-aspeed@archiver.kernel.org>; Tue, 14 Oct 2025 19:14:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cmP6b4yT0z305S;
	Wed, 15 Oct 2025 06:14:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760469287;
	cv=none; b=NfXBK1OhCq3c9Irci6RpXwJDwNXJ8FpVj9YcMiKAbeAqEZEVasTJjRt+KIJ6pudGwvgE6Dd/PP3l9I7zJ66Zq8nOFY+zfZQJElB0g83DC87HQBR0L14h5Pi4zWooq4RbHlAPkHp0PPHDDdnm1ZoaH3W4dRDj5T4SB6XjCa3jHUE/Byq+0IU51xmbT0I1wKcQUNCPpR/pK1EEBW5tbNwJYk4XuecuI44SMGXOEPVuuaftAA+b1NYN8X7SDOipGtNngb/8+7wJn8njroooJpKdQdai6mXVcZx1b7jeBvs1VnCjwK+E32cbpiInJqhSuehcdgHyaziUyx9hRPlrr1XcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760469287; c=relaxed/relaxed;
	bh=QNUximqet6DWhyIz4nhEhfE/R+ezClJhU7cuTBXoYag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9IbQlTg8XmK9oxl5gdO1AmD46+udYSymvxmpC7Act7G5lt4Ee/gmFhsn8Ql7U3q5wUK7oWoMwd/v3rSTKahc9CTRHWE0hoqJlHx3pXonYfIINaTXJw+AdMKN7mfsi2HYbS0MZOqzdPIGlEMPplw3UpQx/8GwtlJ4eEG80dGTnXv09zNL0QHf3EYsnu7BLF4t6OKkurey8VIupTMqaYmi4hAy7hC3wY3HTySudlAXi2ZGbDicV0shvUDfm+3aLe4vW9eOc0FvZtDdhUnn35fkcEvMbNJ9d7H+BRbKFOnWcUaVgvqpdGctko1p/EmVRtzY/sQDvzj9u3eQc8LRXnRAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Xb4AaGVP; dkim-atps=neutral; spf=pass (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org) smtp.mailfrom=lunn.ch
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=Xb4AaGVP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch (client-ip=156.67.10.101; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch; receiver=lists.ozlabs.org)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmP6Z5ghJz2yrZ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 06:14:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QNUximqet6DWhyIz4nhEhfE/R+ezClJhU7cuTBXoYag=; b=Xb4AaGVPDNsB5EUGG4ObRO3h6n
	DdfCBjHziOyMg1DbFj0LI4V46gaeDsVOVqZ7R7SJEGlu8vwilTtUnr+gm3fvdGWgvidwkYMsGBUNa
	+BM7VJDn13srbGPuxSr6UCA+jQGCqnVFKN2/6ObMDl1kAwNsnIYCuNDVFT1nZPUWoxSI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1v8kTV-00Awk6-Os; Tue, 14 Oct 2025 21:14:21 +0200
Date: Tue, 14 Oct 2025 21:14:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tao Ren <rentao.bupt@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: aspeed: facebook-fuji: Include
 facebook-fuji-data64.dts
Message-ID: <33b9d6d4-bb2f-47e6-8d3d-94a2ca2b8474@lunn.ch>
References: <20250728055618.61616-1-rentao.bupt@gmail.com>
 <20250728055618.61616-12-rentao.bupt@gmail.com>
 <79ddc7b9-ef26-4959-9a16-aa4e006eb145@roeck-us.net>
 <aO2kLyxGlGt12sKD@fedora>
 <ea64d3c1-e517-4bd8-9a2e-56432f286347@lunn.ch>
 <4e099ead-e6df-4489-a775-1730bc852dcf@roeck-us.net>
 <f801a4cb-3d27-439c-82f2-d5ee5aa0d810@lunn.ch>
 <7197bfc7-fef6-40b2-b3f3-182e9428dc12@roeck-us.net>
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
In-Reply-To: <7197bfc7-fef6-40b2-b3f3-182e9428dc12@roeck-us.net>

On Tue, Oct 14, 2025 at 09:39:02AM -0700, Guenter Roeck wrote:
> On 10/14/25 08:11, Andrew Lunn wrote:
> > > > If it is already in mainline, i don't care too much if it is wrong. We
> > > > don't want to cause regressions.
> > > > 
> > > > I only object when adding new nodes which are wrong. If we keep adding
> > > > broken nodes, there is no incentive to fix the broken driver to do the
> > > 
> > > This wasn't adding an allegedly (sorry, it worked for me) broken node,
> > > it was removing one that worked for me all along. Obviously I do not know
> > > if it worked (or if it is even used) on real hardware, but it worked for
> > > the fuji-bmc qemu emulation.
> > 
> > It probably does work on real hardware, because it is one of those
> > "two wrongs makes a right" cases. So i see this as a regression. The
> > node should not be removed. It should hopefully get corrected sometime
> > in the future when somebody actually fixes the aspeed driver, and
> > fixes both wrongs.
> 
> So you are trying to force the issue by disabling the Ethernet interface
> on fuji-bmc until the problem in the driver (whatever it is) has been fixed ?
> That just seems odd.

No, i see this as a regression, it probably used to work, so it should
still work.

I'm just pushing back on adding new nodes which are broken. If it is a
new node, it should not cause a regression.

	Andrew

