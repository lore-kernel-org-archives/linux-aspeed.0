Return-Path: <linux-aspeed+bounces-82-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125FBD40CEB
	for <linux-aspeed@archiver.kernel.org>; Tue,  5 Nov 2024 23:21:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XjkqL3MZ9z2xjJ;
	Wed,  6 Nov 2024 10:21:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730848878;
	cv=none; b=nVVVMtLdjPTX1d1oIME5Dszu2vsRCCqbrrQX3jMx+T+BkSN//94s8zh3rqDkImP5WGsLyJW43ZO0bZIUSQq8Phmzm9ksPbERycEyWVIYZWAn5TRDdpc01bFnxEwNYyKlU8nmtBWlCt2PbMYI5fGp9UNlbNRMD8p1emClp1oVcj3uhVGvG+zO3PQk7QbXQZOeX7K8QSlN3S5455Xp6LAalmlUpggpOaaKxXsRlPqYau8WUGD1w9Q81xyr22u4NTM0WRUflLsaqs7zJkg6l0VXBqRnkO3qU5VyqKFyd39J3MMPcRFH/OkIHD5WVS5B3i3kgUI6oPBUErS8a/csq71Hvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730848878; c=relaxed/relaxed;
	bh=9xVg8S5A3dEOoVAga7+s67CM1EOce2OgL3F1GFpjD6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mj1zRousrcxd2A6Q/ne9q+759pLsaMOmefm0KB6J76QT8T6Ak1ldFyiFvlmMYvCax8KR6xrCxQEkD20h9KHvInmjEx7Rku1lCn91sL+vvek6emn9GMn2URBxuo9c8PO3bUuiqJV44Nah9b9vVfsYRmYcYpcgV5/cFVVhY/E13yCnlcyNvuUpcDY+7CYnJ9G8mERJkUHLLM4VpNRfukUYqm+dOz+3K6vkw3wRolOe3aXakh3mmVLeKf6wLdgSQsjme8C4CNmlgOOdrCcEq8RzA3isWBZOwSkF+VIVt4GH47K8dbqk3ROOu5bDBHivzF4QHaGVCTlvji+CwC3UEmJRYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=i2BNR8di; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=i2BNR8di;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XjkqJ6K7mz2xgv
	for <linux-aspeed@lists.ozlabs.org>; Wed,  6 Nov 2024 10:21:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730848873;
	bh=9xVg8S5A3dEOoVAga7+s67CM1EOce2OgL3F1GFpjD6c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i2BNR8diE+bStAGqu0zYAfibKHrcVQtX9N4pflhBAUSdqW9IEM2OcclPJ48QwPlVa
	 GJPIcEHQ2ASnJHrarkOPjgskPbban8Hn+uqI1IOaTF34Pfo5YCoVfWsf+M2n/6+Yxe
	 HUa69kNuNSNjMIUOTEmvYkCVcN5Q/9vBrNM23GmsBzlOUSO+nApi1KChXTFYz2UACw
	 gBWe1Ztlchpgua51i8VwZSFqf0nNaVWpteN1aCTfocGyuikG5JnjYkFT1p4m0xtrkb
	 nhmZHYnuBrC3msnJr5cCJa0Cba3PJcLzi6usLnTXHfmaZceCbF7l2wHkSgwbwqJjl1
	 fivt5GIneEFaA==
Received: from [192.168.68.112] (ppp118-210-162-114.adl-adc-lon-bras34.tpg.internode.on.net [118.210.162.114])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 52A0D6B407;
	Wed,  6 Nov 2024 07:21:11 +0800 (AWST)
Message-ID: <9e9bf461b2ef8993bb46206b3cdf40806a528856.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: sbp1: IBM sbp1 BMC board
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Guenter Roeck <linux@roeck-us.net>, Naresh Solanki
	 <naresh.solanki@9elements.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 jdelvare@suse.com,  sylv@sylv.io, linux-hwmon@vger.kernel.org, Joel Stanley
 <joel@jms.id.au>,  Patrick Rudolph <patrick.rudolph@9elements.com>,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org
Date: Wed, 06 Nov 2024 09:51:10 +1030
In-Reply-To: <7d9657ff-1c4a-4167-982a-9f07e7b51f77@roeck-us.net>
References: <20241104092220.2268805-1-naresh.solanki@9elements.com>
	 <20241104092220.2268805-2-naresh.solanki@9elements.com>
	 <ac9698862598f0d09d35872d0e091537f822fbcd.camel@codeconstruct.com.au>
	 <CABqG17j8RhFpNV+nJ=nLY8+uO_XXjbN55+Ce8op=6Dj5Z=_WOA@mail.gmail.com>
	 <7d9657ff-1c4a-4167-982a-9f07e7b51f77@roeck-us.net>
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

On Tue, 2024-11-05 at 07:47 -0800, Guenter Roeck wrote:
> On 11/4/24 20:10, Naresh Solanki wrote:
> [ ... ]
>=20
> > > =C2=A0From a spot check, the warnings seem legitimate. Did you send
> > > the right
> > > patches?
> > Just checked again. They are resolved. But I guess the dtbinding
> > patch
> > for the above warning are merged in hwmon-next branch & not in
> > dt/next
> >=20
>=20
> Did I apply some patches which should have been applied elsewhere ?
>=20
> If so, please let me know, and I'll drop them.

No need to drop anything for now: It was just that bindings for some
hwmon devices defined in hwmon-next are used in Naresh's devicetree
here.

Merging hwmon-next and applying his patches resolves my concerns.

Unless anyone feels otherwise, I expect we can can carry on
independently with the understanding it will be resolved in the same
way at the next rc1 (barring any other concerns with Naresh's patches).

Andrew


