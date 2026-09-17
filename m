Return-Path: <linux-aspeed+bounces-5023-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B72EC88E72
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Sep 2026 22:27:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hm9Nl6cLHz2xfB;
	Fri, 18 Sep 2026 08:27:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789684039;
	cv=none; b=nccmnFVbqk/JC3mE3CkvB/p4JLPSfSctPJSMivQCvo+sevF8L/LDTViBpfDDkpeWhK4mxhRWJZ2VARrmiyk+Py6O/vQiv33QIg5IeVIXAFQXPtmqTEk3qAjBGt69QaJ5kw6mW6rNbBpHaqzItVR28MPw7Gk06sZojk2zt43HRlK+Y93XEHy8RfpLcc46q8W2hn49qafoWVHJhcWDtBfNkqgelzthUulyNlRgWFJdmnzozZpvcJraZYK8sovA0E5unpFoStB5Pmw9IvcypyjLa6UgSZEGfjqCKtOBThUaZ/lrQS+AZ1RW8O4hUioM4JjlJWzwa6iFrD+9Y6xs2UxXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789684039; c=relaxed/relaxed;
	bh=yqZXwnT4sTbfdvOMcGPrEviywWtc9S3DZ3O1HarHNx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FiCJGQSN8ET5YwfwUud8fgdX4STceZO6DmzAOmj2lKKColP7l37cE9561Wnr/uOgkFXfNNcTCFEirV/TbGoeiTMLpJBO0JBimn8hb8QJiGiWhflctUSfqQGjSIXgxRq2WIZ9HIuDnWhrZL+0wtUBFGkK2hVWouUJYoN8WNt0THUQJei22pbwxUR2svIIK0ZeizLzApVv5e26pJLR50PRRLg3+ki7iLp7qvWIPQUCR5Nh1ZXq+KdUIgSzbVjKu0gyw4YHid0003wex+z6aUKIx7xVGhQcLlsjLFetu31c49CwTfg1iD9LIwj3EB610nKmHjrr8bURue960FJWi8gx8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1Ch8FmE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T1Ch8FmE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hm9Nl1vxVz2xYh;
	Fri, 18 Sep 2026 08:27:19 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 5D54141B0A;
	Thu, 17 Sep 2026 22:27:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36F21F000FF;
	Thu, 17 Sep 2026 22:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684036;
	bh=yqZXwnT4sTbfdvOMcGPrEviywWtc9S3DZ3O1HarHNx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T1Ch8FmEiDOu1G4fnoJuLj1rEhyz4E/ziyDrsJZ9x4LQWGIVRxnAKXftZ6pOkq0cV
	 k/B8IdIfBNledOY1f9g38IVV8BrpBoSMSIu+lh+YHvym5y1Z1NQRJNtF6S3Q7bMBRF
	 dMsU5FV1q4t4A4hIwC7E5PLIF2cNGkC3wolLzWWODHyQxwtkpaLmKs7/zJJlIncvx8
	 NZBsWZICRa0Iq9VByDkAUgeriSBjwz6lhGxW4iCWDZik9l+a1vkX5lWbfhMvYRL82i
	 nbN0PhtXBdsgAigUJoqR4xGqxnL7FxhSzWTFywmuGVz5Pll1HxEfm1SYpAtypTB4wm
	 Nes7zqLQvzOLg==
Date: Thu, 17 Sep 2026 17:27:14 -0500
From: Rob Herring <robh@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
	Oskar Senft <osk@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Vitaly Lubart <lubvital@gmail.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Breno Leitao <leitao@debian.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	James Morse <james.morse@arm.com>, Paolo Abeni <pabeni@redhat.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Dave Penkler <dpenkler@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>, Dan Williams <djbw@kernel.org>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexandra Winter <wintera@linux.ibm.com>,
	Julian Braha <julianbraha@gmail.com>,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>, openbmc@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 3/4] dt-bindings: uart-routing: Add binding for
 StarFive JHB100 UART routing
Message-ID: <20260917222714.GB4081995-robh@kernel.org>
References: <20260905102901.126035-1-changhuang.liang@starfivetech.com>
 <20260905102901.126035-4-changhuang.liang@starfivetech.com>
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
In-Reply-To: <20260905102901.126035-4-changhuang.liang@starfivetech.com>

On Sat, Sep 05, 2026 at 03:29:00AM -0700, Changhuang Liang wrote:
> Add device tree binding for the StarFive JHB100 UART routing controller.
> This controller allows dynamic routing of inputs between built-in UARTs
> and physical serial I/O ports, enabling use cases such as Host <-> BMC
> communication via UARTs.

Also, drop 'binding for ' in the subject. The subject already said 
binding once.

Rob

