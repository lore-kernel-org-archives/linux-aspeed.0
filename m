Return-Path: <linux-aspeed+bounces-1718-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCA87C83F27
	for <linux-aspeed@archiver.kernel.org>; Wed, 16 Jul 2025 08:21:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhptj1Hj9z2ySY;
	Wed, 16 Jul 2025 18:21:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752654109;
	cv=none; b=XUbvJCxGv7b2SEb/pKj/IBEsJuZREj+GkiE1cq1SGN1loqnsT+MWD05Rv8HBKW9L7Zv+uUmIDHjD7xF0cA4LtagGILCarCKbL9Q8TtewPTX2sclu9l5ngyRrb30fRk6i98MWd3XWIKGddVNTiIQBEWhNPilwKsQZ++c0SRhF+knOyogilkxLeaIy9+taDtCAXaeq3RF2YfUr0AihHfniUxKiSEDCP0xYNsdHjOkGIM7an47fwLmdgQPq1Du2zLrclF0+xoFbczJVSK3TAyfCTfjFKyma/gBzdrc+qTcy9XLVAk1vtZwm3g9y+WcaU2t0Gt0n+pdFA8Bsf5TTLIVEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752654109; c=relaxed/relaxed;
	bh=UOMv9U+gZm7+x1wwzDGRIybFy75nzUPgfcsvemOAtO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFeHOU+uKSIC6hNe7KdPuKumJtfdiClCZ/CiC9NCxWZfXBh/VGBZomWAqSy+4xpeoZ5y6he4nBupztlS/O5lGfcuFav0CBdU0yorE450yH6+4EQA4mQsLILVatI5dtCJYU74nFavB5aYeqBVd5gGWDHevBnYIYUbzNd8PO0Qc6pxjjhfys66vt3lCh5PztRsG3dfAs/BSR05/YitWW5hq1X2nGZlkcwoGeJS5Mm4UeY2P+inIPTafz4HHRFRVZwJrmbQa6iFYkZVMIcj4PDvYKZrM10arbRR9O27+ibPROlPGpF9QTmsuvlfIKDfwv+2jLnMNwioey2qC85sG9fdnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HDcIb0sR; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HDcIb0sR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhpth1p4cz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Jul 2025 18:21:48 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D77945C5658;
	Wed, 16 Jul 2025 08:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0254BC4CEF0;
	Wed, 16 Jul 2025 08:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752654105;
	bh=WFDobUiu1Nd43r6dikjiTbbFv38dHAAytYCHWG5v6TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDcIb0sR0K8DHNBwuF3l6zfjuhEd+srpTrUcNN5vM26ynlP8Rapji7XnX3ituaxfv
	 yhHLARSCd4vO8do4/x/xokvvPcPsagYw8XC8YZMWS86u/kZzf0uL+lS0ldVPJI9pGs
	 BcdTW0baB8Y7WwPzvSqC39dhwz6XGPDWwtwPat0/ZA2I7F6qnDMi6YLXwNp4ENPiGa
	 hzuDBsZLIr2l4AdyYD8CrCiGXzPiUI+M1r/nxsfSpG88+LwyYqN3qrn7J7b2bvBJeH
	 mfMjVJOFMAQlyeMGOHnSb9T/9y2gdK1pLfJ+CI4mc8FQ+zKbaDAdY9CfN+IWEiCBDE
	 HNp8KE63b6YwQ==
Date: Wed, 16 Jul 2025 10:21:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Kevin Chen <kevin_chen@aspeedtech.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: aspeed: Add parent
 node compatibles and refine documentation
Message-ID: <20250716-spotted-spirited-axolotl-c94e0b@krzk-bin>
References: <20250715024258.2304665-1-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20250715024258.2304665-1-ryan_chen@aspeedtech.com>

On Tue, Jul 15, 2025 at 10:42:58AM +0800, Ryan Chen wrote:
> - Add 'aspeed,ast2700-intc0' and 'aspeed,ast2700-intc1' compatible
> strings for parent interrupt controller nodes, in addition to the
> existing 'aspeed,ast2700-intc-ic' for child nodes.
> - Clarify the relationship and function of INTC0, INTC1, and the GIC.
> - Update and clarify documentation, block diagram, and examples
> to reflect the hierarchy and compatible usage.
> - Documentation and example refine.

So 7 lines describing obvious - what you did and three lines below
describing non-obvious, why you did it. It should be reversed.

> 
> This change allows the device tree and driver to distinguish between

Why driver needs would matter here?

> parent (top-level) and child (group) interrupt controller nodes,
> enabling more precise driver matching SOC register space allocation.

This just does not make sense. You do not change "precise driver
matching" via bindings. You fix driver. Especially that there is no
driver patch here at all and aspeed,ast2700-intc0 are totally unused!
Don't add ABI which has no users.

Again, you need to start describing the hardware and the REASONS BEHIND
from the hardware point of view. Not drivers.

This change alone based on above explanation makes no sense at all.

Best regards,
Krzysztof


