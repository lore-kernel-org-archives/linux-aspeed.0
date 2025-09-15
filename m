Return-Path: <linux-aspeed+bounces-2225-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4776CCA101F
	for <linux-aspeed@archiver.kernel.org>; Mon, 15 Sep 2025 03:41:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQ9nG5Jlmz3cl9;
	Mon, 15 Sep 2025 13:41:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757907698;
	cv=none; b=hhYPSTc7yJKfymrdiTsqtfLCm1ncUcv46norlOZUKiUkLWjxeRAp7iAgxi+o+fbqSNuWMAtZ98xTlOhJHMVYS82BWS+NDGGJsjhh/pC6N8fYnfs+83WVhMyNvSffoC0tgtIGysI7CYZbz7/IB12hk4KgqGTjbeQxEH731XnFDE3VKPiGIuijWLp3NAKeHc1mwK4WhULPrj/+UkvOUNgQGWCRzFNBKF8EF6fLIKjEw/1B29LyFqRAECiREuNmEgNUJOuIImm3NqIatxNX9Rh6qEMoQy+Jlcyjg8+O7MG/6ftvXcPou/YGZaRYsorp4yQ/SOC9JQTkcymZj+uo1nYUwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757907698; c=relaxed/relaxed;
	bh=McZskAG0UGaWRlZ5lR1vVezxW/M358PczFizXXezyt8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I0/dOouIFnvLHnvm+VhwJv2BwWxkI5b2K//JvO/m6c1L1bHoLnULtCHjY2SkqGYrkq9XzLmEk/YRRt96KLOoYcmo8ePMm6lmrTeM8eCNs0045cAJyC5hiSFywCc+8WYxhwAxxZLJdrgsMbm+lD/rZzLOEigJdc8+DSsfzcT7k9gLJ8JA5PiRFi5LlnQ1bzpPZ+22lWEDQ62r4p5vhkb6vAHb7L9fcZS4qZFtzeimCWQwuF4vIOC0XHuWmAZPSxHHm+WEaQs4cmgeIATLljvsTh6TQhvXGGSkXTCt0qRpEVmA8rb+hacWPFJ6oL7/EGP4ofhY1sWdARQyhtKb2pM8zw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Xcvd+m79; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Xcvd+m79;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQ9nG2QqHz30M0;
	Mon, 15 Sep 2025 13:41:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1757907696;
	bh=McZskAG0UGaWRlZ5lR1vVezxW/M358PczFizXXezyt8=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=Xcvd+m79AusxjVSN/vAg8wz4KIWiLRryRepPb4eS0IUkszuJGo2V11TGyAvc1SqMi
	 9S1J8r+3SD7UrRoOwxjMpTx795/XvVFw55TE6h/q653GYizk/UiZY3p8+ZG5py3MP7
	 OxVCYfPKpPlqAQYZlTX7B83F2QFXuBVrf9xcIb7lNam3d38IAqjnvw3ipfAs2M9Pwv
	 fASRz3/FjxRZNLV8ViFFG0k2VlfDS/im8a80Ib4zgQ1xSfa5RD7PNnf7ljaZYcwYk4
	 2HkpFpETo3rZWtUexQHqjsIV1JDMO9qPgU2t+FHY6y09m986X0HhKK9Cz15owqyw7N
	 YG3MGYCBDbp2w==
Received: from [192.168.72.160] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 68AFC64CF0;
	Mon, 15 Sep 2025 11:41:32 +0800 (AWST)
Message-ID: <03abda47219b8b0b476a3740c7ed2acc4b2b16dc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v18 1/3] dt-bindings: i2c: aspeed,i2c.yaml: add
 transfer-mode and global-regs properties and update example
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "joel@jms.id.au" <joel@jms.id.au>, 
 "andi.shyti@kernel.org" <andi.shyti@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>,  "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,  "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "p.zabel@pengutronix.de"
 <p.zabel@pengutronix.de>,  "andriy.shevchenko@linux.intel.com"
 <andriy.shevchenko@linux.intel.com>, "naresh.solanki@9elements.com"
 <naresh.solanki@9elements.com>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "openbmc@lists.ozlabs.org"
 <openbmc@lists.ozlabs.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Mon, 15 Sep 2025 11:41:31 +0800
In-Reply-To: <OS8PR06MB7541C0D6696FC754D944D45EF208A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250820051832.3605405-1-ryan_chen@aspeedtech.com>
	 <20250820051832.3605405-2-ryan_chen@aspeedtech.com>
	 <9d6660f0bf5119cedee824cf764f15838622833a.camel@codeconstruct.com.au>
	 <OS8PR06MB7541C0D6696FC754D944D45EF208A@OS8PR06MB7541.apcprd06.prod.outlook.com>
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
Precedence: list
MIME-Version: 1.0

Hi Ryan,

> > OK, but the ast2400 and ast2500 I2C peripherals - which this binding al=
so
> > describes - do not have that facility. Given the 2600 is a distinct per=
ipheral (as
> > discussed on the v16 series), this would seem to warrant a distinct bin=
ding.
> >=20
> > Should this be split out into an ast2600-specific binding, to reflect t=
hat it is
> > different hardware? The reference to the global registers and transfer =
modes
> > would then be added only to the ast2600-i2c-bus binding.
>=20
> I agree it would be cleaner to split out a new binding file specifically =
for AST2600,
> for example: `aspeed,ast2600-i2c.yaml`
> But also I think `aspeed,i2cv2.yaml` more better name, that compatible wi=
ll=20
> support next generation such like AST2700 .....

The ship may have already sailed on that one, as you already have the
existing compatible string describing existing hardware.

I would assume that the compatible string should be fixed for an
instance of the specific hardware, but the DT maintainers may be able to
provide some input/precedence on changing an existing binding, if
necessary.

If this does get changed, I would expect that you would need a
corresponding update in the old driver too.

Or, another option may be to keep the current generation ("v2 core with
compat registers") as-is (ie., at ast2600-i2c-bus), and introduce a new
string for the next - where the primary hardware change might be the
removal of compat registers, but it's still new hardware

Cheers,


Jeremy

