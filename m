Return-Path: <linux-aspeed+bounces-3102-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A3BD41D64
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Dec 2025 17:03:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dRzSX20N5z2xHP;
	Fri, 12 Dec 2025 04:03:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765472620;
	cv=none; b=McQHM8cyIe3LmG4hXKqHDzANZEEm8FT/208nGywmp/t5xSi5kWLcR9/K1hZxZpJZTlrAvm6zYkT0z3cw5DG0IyebApFurEXDS3anWRup9939N4n2i367IiapPbKdftH7LzhKatVscJP6w22pFlcpYPylVCYwt3X5ErwZ7BcGFdZmEBb+hgFue3x4lhbqwmpvUdCXKmPDgJxpJ4uMmk+321mL0pSSXH7W0uP4QRuChCMUT9obopo0rQbgYeT310GnMxujUI3yCWY1vuVtqXJddmgLtihXQ4dkT0d7IhTWE8UdIZtZVh4Dy1dowubd3Z9XAFSEdfQ8fFULySJHaLugRw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765472620; c=relaxed/relaxed;
	bh=foEoy2VhimwdSNLHaetZA4VraBbXQ0nSWvrWlsrf9Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbwjvPGNIDCDBwDKPiaaA87hg5p4BVvMA+KY61cgMLaNvu2Uon3XBsnuVAgsu6ZWz57tl4fAkOVyoUZjkqvmY4sxCBtmjg4zfja2ods0AlyYVIDK9uUG9yLOg8uhrhTEbc9njsvBsBR/+tJLutXZP8q4iU8osEmpLICSIk12BY5oqoA9iXCWwYHkzfb0aPHmqwdbEe1xLJxdTRxFeuQOQcNidTsMZtEznqHQs6jzjg3ektfIhML5s1xz2N0yE2D8wR93HVYJ04/fu3n0Q1nfcGhu21EySr55RLywvFbO5wBoXUFf6n1GqSDKTD+PmgrR/oBvfKNzIqzS3oyBkLJW7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YEraNML5; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YEraNML5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dRzSW3G6Zz2xGY;
	Fri, 12 Dec 2025 04:03:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 65BD460137;
	Thu, 11 Dec 2025 17:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA11C4CEF7;
	Thu, 11 Dec 2025 17:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765472616;
	bh=68tWRmyf6VMzwULZOQ9jRTGMGeauu+h01vr63fws4Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YEraNML5j0inR9DRN3T0yMvKx/qUMlxrX6pt2w1kQXcFJ+dgklkcBrCl7lJfcXoP/
	 KQvm2lFNs2jtSb6TCrIUIbE81U47bZzYY17kRquywMWpeEUQeEnhNQZVCrEc7wfZ+D
	 H4u4TN6uPjrBANyvOvTwPDse6CRUlkGacZ8M3ygNWdw/A4SdFSB/5BKX8YYUbJBN3T
	 rwiLbiIoIAcOYnHMyqsVbuypBi8MrNEPQ0aVeLtEiufHBhNCknAN3HJbuv+icg8U3u
	 vvwIggyYfHT3kFAPIzeqq4hj8GV97HM7LEoMSSfBMtzHmmBgLEZhbqJJg90EOtm3VG
	 wM0ep5vPPxi4A==
Date: Thu, 11 Dec 2025 11:03:33 -0600
From: Rob Herring <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
	Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org,
	Linus Walleij <linusw@kernel.org>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	openbmc@lists.ozlabs.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH RFC 06/16] dt-bindings: mmc: Switch ref to
 sdhci-common.yaml
Message-ID: <20251211170333.GA1557987-robh@kernel.org>
References: <20251211-dev-dt-warnings-all-v1-0-21b18b9ada77@codeconstruct.com.au>
 <20251211-dev-dt-warnings-all-v1-6-21b18b9ada77@codeconstruct.com.au>
 <176546866607.1487115.6798113196659439308.robh@kernel.org>
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
In-Reply-To: <176546866607.1487115.6798113196659439308.robh@kernel.org>

On Thu, Dec 11, 2025 at 09:57:47AM -0600, Rob Herring (Arm) wrote:
> 
> On Thu, 11 Dec 2025 17:45:48 +0900, Andrew Jeffery wrote:
> > Enable use of common SDHCI-related properties such as sdhci-caps-mask as
> > found in the AST2600 EVB DTS.
> > 
> > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > ---
> >  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/aspeed,ast2400-pwm-tacho.example.dtb: fan-controller@1e786000 (aspeed,ast2500-pwm-tacho): #cooling-cells: 2 was expected
> 	from schema $id: http://devicetree.org/schemas/thermal/thermal-cooling-devices.yaml

Not sure what happened here. This is a real error, but on the wrong 
patch. The already applied change here looks fine.

We need to determine 1 cooling cell makes any sense or not, and allow 
for 1 in thermal-cooling-devices.yaml if it does.

Rob

