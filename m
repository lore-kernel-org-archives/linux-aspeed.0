Return-Path: <linux-aspeed+bounces-5198-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C30CC6B2D
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 04:33:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5X730bbkz3btP;
	Fri, 16 Oct 2026 15:30:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792058058;
	cv=none; b=mLrCxToapVs3MbM267nSWS//cYNru7oqyDU/1uBIodqRgMJmROBWqCUen2xvCNGsAXwwz3QMWMbzAJdXANTrY/uy5CUJP0BjKa2AxjT1XXSYC3O6qd5uPZWd6C+x4+VN5+GTTuPbSTqbvYqE/JKfPdss520ZAgiQCibZRHplYjbzwCerKIeVsK//ko+bDnXFAN1mUYdKpYunmMuMpGCPKmIr55gz8wZjn/Ap3zvOOVsfo+KvxNkBDFWIH42rueEgzEu9c/cnrDYvxX04uxlCZDi5EgicOow9ChVD9uT4Re7QNn5Rej+v71kYf/anuCxPaG64LQfpO0ixqm4peshOxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792058058; c=relaxed/relaxed;
	bh=FTiAObyAESh3G5YxQwvY1f/k5aL+7XVnCiMQ+GLcbRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G61YYjK936MxMHX0r0cYmqgrSrtjlh+kFd9+kbhFIi/fDc7wIDude9gxBYUK59kFosqnY1C4rpQ/b5oB1ZFE/IoR+qyq0DiLyXrqw+LeVSprDJMyVAeZYz38So2eUTeGoF/6EVpFOqt9sseACbp2KJbDngFM+NfnmAL/pJfTfwdQe+IEJS0v6YzgerfZgY/RIKUI0yVZTZCoCRdo0KapyNeqREYRW3spybJxbvVlTpbRYHyO+megpsFuk+lA+XOBWwj309yY95uXnuJJjIaq0BJzZ+zXaw669JuYaBhZJvHKTUS1fSSIjEHd84GRziIEEps4db9xpubW+lGpT9wmFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=dNnLFCDd; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=dNnLFCDd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j53Lx2Lssz2xM7;
	Thu, 15 Oct 2026 20:54:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FTiAObyAESh3G5YxQwvY1f/k5aL+7XVnCiMQ+GLcbRk=; b=dNnLFCDdJxUFAnrNjRUh3QEdY7
	2KbWJtVpT8MtlXfHPk4eNHJ0WK0IHo26G9EEcRYvjgB21eaBUz8/eg+lr/VKHV4xsxuwxhEgClC5v
	Sin9Tp+SerlmItUku+HmrO1sk0egRZlwpHgJrGq3UC1n5SnbgDFZq4A1N8KVgXVsM3brOzcMfZX65
	CScOmGCD+sEkN+ZwDz0wRROYnLq8o4GpMh9Y0DKHQHUA5UsZI7fu/fg0t6eIoPWVOVmD94lCBg03U
	kdUaj7kaHdSWHDTbKli3+NrOc89nucwHa/GwQQCF3dTFnjvtB8NZXVsHY8IQ7+1710ULQyru7cUbR
	cK+eNmHw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xHI94-0056ak-1F;
	Thu, 15 Oct 2026 09:53:06 +0000
Date: Thu, 15 Oct 2026 02:52:58 -0700
From: Breno Leitao <leitao@debian.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
	Oskar Senft <osk@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, Jani Nikula <jani.nikula@intel.com>, 
	Vitaly Lubart <lubvital@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Usyskin <alexander.usyskin@intel.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Philipp Zabel <p.zabel@pengutronix.de>, 
	James Morse <james.morse@arm.com>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, Dave Penkler <dpenkler@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	Dan Williams <djbw@kernel.org>, Mukesh Rathor <mrathor@linux.microsoft.com>, 
	Vladimir Oltean <vladimir.oltean@nxp.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Julian Braha <julianbraha@gmail.com>, Karthikeyan KS <karthiproffesional@gmail.com>, 
	Pengpeng Hou <pengpeng@iscas.ac.cn>, openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v2 1/4] uart-routing: Add common UART routing framework
Message-ID: <atCibvmbCSTMTMYD@gmail.com>
References: <20260905102901.126035-1-changhuang.liang@starfivetech.com>
 <20260905102901.126035-2-changhuang.liang@starfivetech.com>
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
In-Reply-To: <20260905102901.126035-2-changhuang.liang@starfivetech.com>
X-Debian-User: leitao

On Sat, Sep 05, 2026 at 03:28:58AM -0700, Changhuang Liang wrote:
> +ssize_t uart_routing_show(struct device *dev, struct device_attribute *attr,
> +                       char *buf)
> +{
> +     const struct uart_routing_selector *sel = to_uart_routing_selector(attr);
> +     struct uart_routing *routing = uart_routing_from_dev(dev);
> +     unsigned int val, pos;
> +     int len, ret;
> +
> +     ret = regmap_read(routing->regmap, sel->reg, &val);

It seems routing can be NULL here if the file is read while the device
is being unbound, and uart_routing_store() has the same problem.

I hit this while testing v2 on arm64 (next-20261008 with KASAN), and the
code is unchanged in v3.

        d=/sys/bus/platform/devices/$DEV
        drv=/sys/bus/platform/drivers/aspeed-uart-routing
        while :; do cat $d/uart1; done >/dev/null 2>&1 &
        while :; do echo $DEV > $drv/unbind; echo $DEV > $drv/bind; done

and then got:

    KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
    Internal error: Oops: 0000000096000006 [#1]  SMP
    pc : uart_routing_show+0x64/0x288 [uart_routing]
    Call trace:
     uart_routing_show+0x64/0x288 [uart_routing] (P)
     dev_attr_show+0x64/0xc0
     sysfs_kf_seq_show+0x21c/0x380
     kernfs_seq_show+0x138/0x1c8
     seq_read_iter+0x358/0xa30
     kernfs_fop_read_iter+0x438/0x500
     vfs_read+0x484/0x6f0

--breno

