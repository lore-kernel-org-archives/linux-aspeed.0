Return-Path: <linux-aspeed+bounces-4654-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5FEC5AC9E
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:37:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcw325k3z3c1w;
	Fri, 07 Aug 2026 18:37:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091843;
	cv=none; b=oMrw4NeB0H1kG43RNCEitoQMiYkJ4FUorElS141WgC/t0J/tc49Xubs9Z/sCn3pGXAPUq+/kWaiqk2ObtCpOpE6kgzXcJ6ZTpiI6wvn76oInIlY3BQI4TNHZQqSBdoWW5dZ8CGUn9LjK9QQo6NMTe48r1GrU3YQQDYzEcZVmxLl1/O+O5aJvSZ3nOKX36VBxH6uC9HjyXjwWRQGBi02DxE2Ot0P74/zFiaPGsdNs33OCL8H5dNiGhESHhR87ALihGndLX/uVILsjP1ctMB42YhZWkz6Akv7Esnz3YkRAzQoUCHY8IBD88rr0bJAbhSyNBVvcHfhiostzwEljjco2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091843; c=relaxed/relaxed;
	bh=eGMUF25P693ePk/L/oUapnM3i3tck6ovRZHhcpx3Kbw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LdBNBK3dHVrE49rFzwOq7x1iOYfP8yIUUyHPNfbSXsIOCnjwPXo94S/yvTYCnnUkiKuigkBP9d0QLp0ypEDIrwgRt79PDfYfVqgkOT62n3C6l3/zFjnbx5Z1C/Ziv7Pcnp4cWzJaa2Snt8WUUvJfWDBZh2iQlimgi/BF2bjpj0gEEayu1K1VeaWO6Sm8spR3UGKOUTmOkl0FjPEXp/Q9PEuyl6M/uWrbjJQsjlRH4nzPnruK4UQZaGpcRx5SZptXyKkZYnHwLeD6YZ7DsMRMVq91G5pP0ux3vBZnfzTd7OOAwUrUD3NevFd+mIPPirdCuBCXhd9m7+OJEqiw//lmaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=YpUVBOI7; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=YpUVBOI7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcw21vsqz3c1D
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:37:21 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-493b966dd74so18843905e9.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786091838; x=1786696638; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eGMUF25P693ePk/L/oUapnM3i3tck6ovRZHhcpx3Kbw=;
        b=YpUVBOI7cKLtaipkM+9jDvhsYxw5sr5/mgvSdXCaggpdDBYj/FlpzvvL+kjAhVwQHR
         XEUpJY8u/dT7/NWlTpAi6gMjkFHzMq6X26qW4alp9LF1TkpgLXPbECypX9cqzVWhsDtu
         71WbX5KBFRqHacd2Ls3apzdTA1H8J6Lmfy7dlTsm03F92h5NG5o3S4eX04VvCvsQNNKw
         yKLrzj36acyxbwOrZsyrZZp8iPu6Zu/4tJx8dMAXeeqydzlUa6rPmVRjCeM4DwZOyc3U
         EtAIeTzh65JBXnt3iDRRE+Ota4d6iNFs56NvKlrtwCqqIg5+rsZlEisyao1ypfAeVga4
         fWVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091838; x=1786696638;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGMUF25P693ePk/L/oUapnM3i3tck6ovRZHhcpx3Kbw=;
        b=AH39v5xJfmrS0XeiENLngXTKnqEWB2p4+m8fC8NBgJ7Z16glu7RdIoi2QyHck6M9r/
         e/KM9K8u52Jr6ONeeeREOcKKVbc5zeoQ+85WkcX3bXvt3LjbFdmGFfk/kGAi0cHuyvyV
         v9lbcTkKDQ8Dcmkrc6OlU7iUMIP0/ifY6wszln0OzFv+bZZCNM2YfiarRql3t5iSuFhH
         cx4VwcGEwrSpGPzUY063WhX8cBPblb54DTQADzD+e9vUdMVm+0jAP8lQfOKoP8yTZCFj
         WpFH67VZi0bbZNlmFiCqI+U8ZQbjyicm6aiQsAET06EmYGlg+MIUvbzDmug7u02wwqFa
         fsWw==
X-Forwarded-Encrypted: i=1; AHgh+Rqh5ZnwlBt6NBuJx9wPbve0rOqvAXw70nCwn8MPvRebvnG7rIL+47vijeIbgwca4Vnf607DtQZlmNnhb/w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywf24LSb8QIqQXdAFrNDuouGnH5XN7w78YafBpBXVtVt59fjSbJ
	6LZwU8rXudvEZsVHN8mjCKcVATbbBXU+BZqCcbF50wzqUj5hgBRJ5hsVjWzJ0xSWMBU=
X-Gm-Gg: AR+sD13A5K4iQl/usGzs4SZHha4SQ0pd4QUVxbgotIaMDH7e+iWqA+8nJL9OWuskkL4
	iGUhqwL7eMyP/DAHZx2z7cR1i/8OFlnS3PtKsA6WETGhW/zyn5ElwUvZZcLgmsd2bWKPl/6t1zH
	QDAUTtTXbio2JtELhepo4pTJSdj/q8HfGsXxFwME3829bAHisLsW03FHU1tS7UJ4njjSeap3B7+
	2Pmt6UpppGuWnOQWSghP+Cn5gQkKQJbp7ztueLJF59CS3EXMRdvVx6d8R3lIdNeU9/u3kM0J2hd
	u7hJji04xBM28X+ilU3sh99MwdwypVeVnzyBgS0yW8sXRJ0fjSRvwqvft3L6SyCW6xDUm6XEpVv
	UoTVG7siA8oTzywB/fBPFayIWT5XIOeqWdwoyOih94XBWehFItRE9qDSuavy9Fe2pvUNS0Llpq7
	JKIq7zPHidQcYNvRdiKvFMx6D8CD+0aeRcnQL5ELJsAceaZmD58IBselcfV0yLGsTZFqnvOK8=
X-Received: by 2002:a05:600c:3226:b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-4994e7ce0dcmr191510415e9.13.1786091838712;
        Fri, 07 Aug 2026 01:37:18 -0700 (PDT)
Received: from [172.20.10.3] ([2a01:599:843:2744:7f5d:3df0:76c1:3705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e7171sm17795195e9.1.2026.08.07.01.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:37:18 -0700 (PDT)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 5/6] ARM: dts: aspeed: g6: Change vuart compatible
 string for ast2600
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, lee@kernel.org, andrew@lunn.ch, 
 jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
 anirudhsriniv@gmail.com, tan.siewert@9elements.com, 
 linux-serial@vger.kernel.org, mfd@lists.linux.dev, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <d54bfe689e6a0f318961588ab6b72fc2b09ebb47.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <d54bfe689e6a0f318961588ab6b72fc2b09ebb47.1785932211.git.gregoire.layet@9elements.com>
Date: Fri, 07 Aug 2026 10:37:09 +0200
Message-Id: <178609182923.193353.5571242599516025969.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091831; l=355;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=fuFEj1OU+QhcCZyLvfuNnHiX6rf0ZBxSPqBHjTqQNjI=;
 b=l/snFEuA6s9C2vYf6o5nTOQ8zlqd9Il9CufwGf1MkTpOA+4+PTdQ2n5jUh9glDVuzfjCNBQVJ
 WDZc+yLTygNBpO/pif+3n/9h9ZDIVzxwiVZwcXHim3sLopjfT4uTkcv
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

On Wed, 05 Aug 2026 14:19:52 +0200, Grégoire Layet <gregoire.layet@9elements.com> wrote:
> Use the ast2600 compatible string.
> Make it more precise and enable specific ast2600 properties.
> Still use the ast2500 compatible string as a fallback.

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>

-- 
Tan Siewert <tan.siewert@9elements.com>

