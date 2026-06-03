Return-Path: <linux-aspeed+bounces-4183-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47003CD6E57
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Jun 2026 23:49:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gW4DQ2VYbz2yS6;
	Thu, 04 Jun 2026 09:49:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::431" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780494231;
	cv=pass; b=c67WHrEEcYGcipSGhu/cLdv461Ldw0S6Z3ypdIOeQ5rgSuqoYaCs5D6C1XYolNnaPTy8eOM5UZzTcT9C94o5iUICN/QMyJ5HnYHjvF8Dh/Xr/kf+ce5OaQK3fcVQ4aCRsdsd1tHbS0bb0cpjnm51yrKxcsVKQv5jOOS7T65LJ2Fpzn8OSh+E+IfMrZtT+cJnDDuh4fOK9TEaASL4o+DNWeSJ6NBOlHBTp19oQD3WbHIjzFAZ/y4iuzNoHp0HTNVNr72tplOkP268a8kviLeNGw4XXved9Hra8vCfIdA7sSxCt+GF3FIaU+gzYD5t4DqntrMmzEZs48n5I+fPLVD8KA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780494231; c=relaxed/relaxed;
	bh=VTcfkOPlIW892EhdMfr5qQk6TfDhlVCXup0babukdvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dIVJUeXjnGYOqerw1L+qKnMkBD5A25QZg5I6hWFJtjTFRXnSL1khFi5v9CbW/7BgDJWr+xk8+nIhtcjxemnwTs+APzFY2YJ0pRfTOd1baE97hBwRLwQeyxOaO6n8+No+v+sznajnKw9c1UhAPLC1Rkf18DxK7Vx+dMdb9Te+x9+tMTfDSSMMxbug4vibssR6MVDA5eMNtL6RRMiS5prJ5joGS/nWOQBEjKD+rLKxqrM++Xik/cT3zjmC7md3fIA82nmGkU9GgLzDSMT+Jrqws/HbvnuFK/vUvrFFv3rtTfNK399nivn0lUMUcj17VNPD5nfzgwTab/olhYxiPi0c+Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=bwgQNB/f; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=bwgQNB/f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::431; helo=mail-wr1-x431.google.com; envelope-from=gregoire.layet@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVpnf4nRcz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Jun 2026 23:43:50 +1000 (AEST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-45e9f4a3510so7408148f8f.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Jun 2026 06:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780494227; cv=none;
        d=google.com; s=arc-20240605;
        b=Xi72/vg/o8F0q21E1aSR9gF3GEPRz009ddzvPjLtppH1xQpAundLVLoP9ksmDMXtZM
         xkPC3nWl0RVckAJPF8GKzFlQ8j+CJP0DJCG2G/l+fdsC0gntdCstafCl5ObqPTdnGKgH
         l5iCsBPSjuqqeuUt/yOm53yf1FYVTSzUUv/ta2zfeRK7utsGRulmLvJRvZ2fIKdS63Py
         1kxCpEkwMU0uog1Qv5XqrEQfMpwRvO8+79QLaKxB3QP4sb8aEzcgoK29F8P6qP4PLMVw
         Atp51zb5ZjW2qxMSheGoMpw9fpHEW4aDiqMqWJfgY9ywwKUcRAihpfq0XLd500DjXDQ0
         vXaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VTcfkOPlIW892EhdMfr5qQk6TfDhlVCXup0babukdvQ=;
        fh=oQ9MubOR0B7SQcI684Pu+wBxiU2EtEOrjur3taMC7bs=;
        b=LTUCCBihFCTntQTgM5CAFSXJ6kw1c8AnAvLrSIB5acV0NkukUV5DxqM+EwwxseSifx
         K6RP/eLKLTpUWQFbqYWkNf+YFjbHR637NSanygsMtR/Zu4Y1sMQPhR1unFch0ltPey0y
         OGLzZwBYrkSGqrX8X/MimD2dIbYAnvOEuDc/fWSOhZVfLuxCPj3qEpgZ8qtTNvVb2bH0
         Mp3cIQPxa+dlGXG7E4UX2CytRpOqVXpD7jLKevTQP1vQsAh8MTJlrcBEAwCY9SKDkcTD
         WhQwJssyoGw6wilhuMVBhzNcUqHSmO3EEptQUJ8XrOJwsSwuUDOGBoQ9k7v2AE75YlMC
         1JZQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1780494227; x=1781099027; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTcfkOPlIW892EhdMfr5qQk6TfDhlVCXup0babukdvQ=;
        b=bwgQNB/f9EzHVNPTijatU04dJUB8lx68N4olwAKihRYbduZnYzYZc4gwyJFt2d4RRN
         QJjz/fLL5EBBO1SknhGGyQUCoZiVMpnD6tHTq4l9MqNcn/Xbtz0pf4ZJJq5H0VvNcXBO
         NH9x0D7GN7d1qkBPeJfJh5BN6xE74yp+AvF2tke4JXs0UWB2nnqYzSOIF885V4yzbDBL
         Raie0/4mnMlU5K9UzZoC8eB/wCyCV2/xA+pUjpoetaagb3OG2J5Jf+//qhZg/meE9TBO
         m4pq/cux+6SdNwF7Cromn/xfxXWC1te+CW4tJMode8JFQpQ38fCcoWY22WjxsBUuFlVP
         S88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780494227; x=1781099027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VTcfkOPlIW892EhdMfr5qQk6TfDhlVCXup0babukdvQ=;
        b=iHMLe4rcAAWbVlig6gf8vVF27osFC9CnqOvfljFyRYC/MBZORQz7DoyDcyhGA58WTX
         THxFBIvDZ71x/sQMpL1IVv9ubSJY2S/LZGM5xpElsm4YOScDd9q+7QIWRJnCQ8mAroTB
         mfxGXg4r3E0TCppdhaDbqVrqEPpSiBfZSQyxSwx6PLcAU1hIpTnw2C5+gxEsM2TifAjP
         IZCarafTBtpKZMXfoj7f8JzquT7kH7EwUhnTZWyggUe0nLDSF9zWWzvIzNI40Y62OVoI
         uicZp7BqKAR5wHMk+rRMEO4WT64dK91mKjwQVV8WG6zBcYG876Rc1ENW2F1AeXIIA2Q9
         GVTg==
X-Forwarded-Encrypted: i=1; AFNElJ+kr6CiYlXal9+haq1AqXQAlFndhcb5xSmVMJliXVhZaFrQt7JtWWY00StnESaLV20iEyprsdXNZQY1RA8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzy2pVGJL4ooVhHDeDfPe6fIHBx69WoixWwOaxUTXDRKIZK0LUG
	jUZTeE5XZElbpK0e4EwTzcbmQU52TU8y9Hv1flwy6dx6q14HJg/zaEkswekKEiTWkGn+Cpqpa3n
	dsf98+aalESm4kmtCZ05C9las5bqffBiM8/cx0kNy6A==
X-Gm-Gg: Acq92OHO9BS/fxmPpqGu9qzUZVDTm8/AyVgDUJewHB4OiqXEc9G09PYssE+1taBdmzH
	9KdbELt0ybYK0z/5KSaXORpXAFsjt0+xKR0ZtdB9UzuWhKs+dJuhTAhz2Dw0buQqgsqBEBSDv8K
	vjhknbg8loAYRVAOsiOXwHLhLPgi0iMXeOSn8QnWOWAyh8FlSIjWXbPYvUlqGYXt73AzJu+nNgv
	EvSibVNlrnTLBhcm8DsrUcc8C8Ki5U+vd8rwz3JZblo8xwqigjp9Fza4DVM35AfZeEa28YINzxj
	4MWYtAIFBV1KbBvA2w==
X-Received: by 2002:a05:600c:4513:b0:48e:7854:1608 with SMTP id
 5b1f17b1804b1-490b5fe9bd8mr58678515e9.25.1780494227210; Wed, 03 Jun 2026
 06:43:47 -0700 (PDT)
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
References: <cover.1780409151.git.gregoire.layet@9elements.com>
 <a8e1396af1b6db38bab13383c6ba303e8427aefc.1780409151.git.gregoire.layet@9elements.com>
 <ecc3bd49-829f-49b8-b3b1-4f16363ea5b9@lunn.ch>
In-Reply-To: <ecc3bd49-829f-49b8-b3b1-4f16363ea5b9@lunn.ch>
From: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Date: Wed, 3 Jun 2026 15:43:36 +0200
X-Gm-Features: AVHnY4KAjzRL4EZ-_z2w7gIb7xHs465qhHFgOBjhOy8lDYI40Oh9lKfcinUsrDM
Message-ID: <CAFi2wKY7ECbxSbtsO1W9KEKFET67yKg+C64jtQHFY05DRzhfKg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] soc: aspeed: add host-side PCIe BMC device driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, jacky_chou@aspeedtech.com, 
	yh_chung@aspeedtech.com, ninad@linux.ibm.com, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> How virtual is this? Is this directly accessing the hardware via
> shared memory? Or is there software on the BMC which traps these
> reads/writes and responds?

The VUART is virtual because there is no physical UART link between
the host and the BMC.
Instead, the AST2600 exposes a 16550-compatible register set on both
sides (BMC APB and PCIe host MMIO).
The data flows using an internal 16 byte FIFO shared between the two
register views.
So it's hardware emulated and there is no software in the data path.

The AST2600 has four VUARTs, two of which are accessible via PCIe MMIO.
This is based on the following section of the AST2600 datasheet:
III.48 VUART and III.64 PCI2VUART.

Because the silicon presents a standard 16550A interface in hardware,
the existing 8250 driver works without modification.

> But first we need to decide if this is the correct architecture. The
> alternative is rpmsg or virtio.

> Either of these seem like a better way to expose resources of the BMC
> to the host.

For the rest of the driver (shared memory, doorbell and mailbox), you are r=
ight,
it makes more sense to implement rpmsg or virtio than just raw shared
memory binding.
These are software-defined communication channels and not hardware-emulated=
,
so they would fit better as rpmsg or virtio drivers.
I took the SDK driver as a starting point without questioning its structure=
.
I have verified the VUART was working correctly with the shared
memory, doorbell and mailbox setup removed.
I can split this into VUART only and defer the rest for a separate
rpmsg/virtio work.

So I propose for v2:
- Remove the shared memory device, the sysfs doorbell and the mailbox
from this series.
- Retain only the required configuration and initialisation on the BMC
side driver.
  This should mainly be SCU and PCIe device configuration but other
initialisation will be reviewed to determine what is required.
- The shared memory, doorbell and mailbox features could then be
addressed in a separate future series, likely as virtio based driver.

Would that be acceptable?

Thanks,
Gr=C3=A9goire

