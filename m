Return-Path: <linux-aspeed+bounces-2208-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088DBCAC58D
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Sep 2025 09:03:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cMs6r4cngz2yrF;
	Thu, 11 Sep 2025 19:03:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757581428;
	cv=none; b=SWxUoLAXSYqWBxyYfyzOGQYAYhO07Menv170A/5afRLdEdSNsN8pRVYMZOhiEv9UDRSTHY2yEBisopm4r5WKRE0X2mKD5hIXZokRwAzaBRRz+KCs6jrxPEmSgirW0ZROQW6lChD4ovp/eTux8Lfz5OY4M1ZFFd9XU2NnaaUX/u5r/cBa7HRcGGVYjNQSFEhq4kjOyDRRQl6522izMsbbOpIWrrVk2VqmUQyv91AJxesE6gtyVtqdlGFt2K9ycOJSr9xZU0ZsnPI/4NTUk8mGhTlePu+aBuFNAH/bIy8mlx7HQ0qcA5Rko9ScyOWvWepUHUnLG8Z04hPsKbqzoau4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757581428; c=relaxed/relaxed;
	bh=9jGcvOJ/2zIoXs3jwzmzA+R7eyYFP6KicLp4LvaH6+s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1PM/KEp7WRpZ3R235F1DRvv/olZmoPa91LJKkpIRixEx4duwgxa9g9KmivsZsdXG3kmTd4itwUIbgT/ydBHeplt/6WKUaf4BZ8LHex0EqtcQaBQ7CfaWfKUU95bR2Q0vcxrLk5xViLowYSo3Tp1C1Mb2IU9FX/Sff71gDG3sI142iCp38jJnKQb31/30aNvm8UUS8xrchRfoxlqiMbNtebkEAdGJVhO4QnCPpFQ7TdU7E0B421VUTiill6vGpO1kIb/ZiwJ3+z1I+N5/TywY0t2OVnFJMc8VdgOxF+9wNKdATSTOOqlYI4sPTHw7LJBuNQdV+MkeSJLMuPQaP2BPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org; dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=eC7I0Sd8; dkim-atps=neutral; spf=pass (client-ip=150.107.74.76; helo=mail.ozlabs.org; envelope-from=jk@ozlabs.org; receiver=lists.ozlabs.org) smtp.mailfrom=ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.a=rsa-sha256 header.s=201707 header.b=eC7I0Sd8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ozlabs.org (client-ip=150.107.74.76; helo=mail.ozlabs.org; envelope-from=jk@ozlabs.org; receiver=lists.ozlabs.org)
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cMs6p7547z2xlM;
	Thu, 11 Sep 2025 19:03:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
	s=201707; t=1757581425;
	bh=9jGcvOJ/2zIoXs3jwzmzA+R7eyYFP6KicLp4LvaH6+s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=eC7I0Sd8DAcvARRMk7gSLhQfnmUYQpLWw0SxQbapw03i3+CqDJ3UVERzC74tH33Dy
	 Ev7bCORrnoI/zq+uiGhuXWrvVHwT5E/MtrfoUVD2NxCklYAXuEZTXDodeHN1XazLlu
	 4sQZlAZzfCLkwaW3cXZhRKqE5zLOwUfXqILuCVRQEGGPq+WE5xqzeDjqCvAqQxSsIH
	 BF1JxnA1xoFgifHbGydZIM7AEO2as8uTEF7IMa+pcQrzxjHmIfw7G6TcwSYL1U0F+g
	 M2RNjT0NsWWdJNdhKrwwXrVihmPPk1a5WhHTay4pLIFUxPqgEXYFpSR4Uc2r8vWnXU
	 nLrlVqMRqY35Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4cMs6l4WjPz4wB0;
	Thu, 11 Sep 2025 19:03:43 +1000 (AEST)
Message-ID: <ecefaed7ed0fe83442021c0bfee0a49111269aad.camel@ozlabs.org>
Subject: Re: [PATCH v16 1/3] dt-bindings: i2c: aspeed: support for
 AST2600-i2cv2
From: Jeremy Kerr <jk@ozlabs.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Krzysztof Kozlowski
 <krzk@kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	 <conor+dt@kernel.org>, "andriy.shevchenko@linux.intel.com"
	 <andriy.shevchenko@linux.intel.com>, "andi.shyti@kernel.org"
	 <andi.shyti@kernel.org>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "openbmc@lists.ozlabs.org"
	 <openbmc@lists.ozlabs.org>, Mo Elbadry <elbadrym@google.com>, 
	"linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "joel@jms.id.au" <joel@jms.id.au>, 
	"p.zabel@pengutronix.de"
	 <p.zabel@pengutronix.de>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org"
	 <linux-i2c@vger.kernel.org>
Date: Thu, 11 Sep 2025 17:03:39 +0800
In-Reply-To: <3fdee5330d91b5d18a69a311e4df6de874973ced.camel@ozlabs.org>
References: <20250224055936.1804279-1-ryan_chen@aspeedtech.com>
	 <d1b184c5-84c1-4d76-a1d0-a9f37f1e363c@kernel.org>
	 <OS8PR06MB7541D1D2E16C5E77037F3BB0F2CB2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <069b9fe4-c54a-4efd-923e-1558c59fe3f4@kernel.org>
	 <OS8PR06MB7541C69AB8E6425313DA8606F2DF2@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <677cb075-24ae-45d8-bfb4-9b23fbacc5df@kernel.org>
	 <OS8PR06MB7541C3B70B15F45F4824772BF2D92@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <994cb954-f3c4-4a44-800e-9303787c1be9@kernel.org>
	 <SI6PR06MB753542037E1D6BBF5CE8D2E7F2A42@SI6PR06MB7535.apcprd06.prod.outlook.com>
	 <4523caea-3406-4de0-9ab5-424fb7a0a474@kernel.org>
	 <SI6PR06MB7535BAD19B51A381171A0E64F2A42@SI6PR06MB7535.apcprd06.prod.outlook.com>
	 <8e8aa069-af9f-453f-9bd0-e3dc2eab59ab@kernel.org>
	 <OS8PR06MB7541FD8691B43EA33BDC1D22F2A72@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <99053328-a117-493e-b5f3-00902669c8e7@kernel.org>
	 <44ef5c93448a3625fcfd003b47a516e8ba795b62.camel@ozlabs.org>
	 <f9fc4b59-bdcd-4983-b7c2-0fec94e62176@kernel.org>
	 <52943e49aaea7bb6def5bc51dfd57392b6ae66e4.camel@ozlabs.org>
	 <OS8PR06MB7541BD362CE9FC0AA3CFC46CF209A@OS8PR06MB7541.apcprd06.prod.outlook.com>
	 <3fdee5330d91b5d18a69a311e4df6de874973ced.camel@ozlabs.org>
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

Hi all,

After a bit of a chat with Ryan, some updates on this:

> The question was more: it sounds like you're switching between
> *fundamentally different* hardware units with the mux switch - not just
> a different register interface for the same peripheral hardware. Is that
> the case?

Turns out: no. The controller core is the same, but what gets muxed
in/out is more of a compatibility interface. This provides an
ast2500-like register set to the ast2600 i2c peripheral.

So, the plan to use the same aspeed,ast2600-i2c-bus binding for the
controllers (ie, as in v18) seems mostly sensible to me.

The newly-introduced driver can make use of the non-compat interface to
the peripheral (using the existing compatible value), but needs the
introduction of support for the global register set to do so. Ideally,
this would have been included on the original spec for the
aspeed,ast2600-i2c-bus binding (since that's how the hardware is laid
out), but that wasn't the case.

We may want to split the aspeed,ast2600-i2c-bus binding out from the
existing spec, as we currently have:

  compatible:
    enum:
      - aspeed,ast2400-i2c-bus
      - aspeed,ast2500-i2c-bus
      - aspeed,ast2600-i2c-bus

- but the former two do not have a global register-set.

We may have better syscon-like options for handling that global register
set, but that's more of a conversation for the v18 thread.

Cheers,


Jeremy

