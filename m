Return-Path: <linux-aspeed+bounces-4652-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFDDC5AC7A
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:37:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcw2019yz3c2C;
	Fri, 07 Aug 2026 18:37:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091841;
	cv=none; b=JyxXBKFMNQ+6cMsCV0rksm3e1RjUz+3OZOpAACjDvEbYo0jWP36WsYuKQCxYbwl0+FHrGxwqidOm3YveWi+DPg6acXK1aDjTGe14ZyTuQhPYbmT+3oh0FQWRNnii7/2nXEuhSVkBBs6L6yJgMfx5f4W2Y/EDunO6sW5ZFDtYiavxBjwMexIXkhiauz/lvDKk/EP1+RMG4A5MYbqr+AtqdDyPslzifvdItw77ywFPiHm4+Ku9OqsTcNy3W59+1FvkG2XA8IBaXwSxNWmAxTc19z3mXPcSxFoRSDkcFiQifdOvOy2PcjDeQzrLsgIYhwC+4TB4mXy6eknGraAK1X9srg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091841; c=relaxed/relaxed;
	bh=jEYndMHB+hzzoGm3/jN5rHUQhOLtVYWufPY6GQuzOfA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=g8NLik6imvUsFKbSgM7x6vPThXnJOeLpumUhy4PvyRnSFKxwlR8Qy/el70YkourWtyau31V1BRqGxS0pVnjHO1Kc2UBpH6tfJQURkotGnxLLXxu0bZyFKwgN7vJ/WDjmY/4ZZ2TgiN9w+bSXMWO3l4SkHLyeNHLt4jiY61WDxGf6YyfblaogWJCQ8NEs7Uot0zRl9wgLeQEVCqEQQ66xB/2M+t57x+kgVRzlE9TuWAD28ckEw5k3lewIHEvlYbl/65nAj9tu8dndAaXOU+wrpFMEB36FqjKl4mSa9G5KxeBGgS8euFPUd0sIbNCW4kfUHr50NPv3qTTX0gCKPkEbXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=YpB10Rc+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org) smtp.mailfrom=9elements.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=9elements.com header.i=@9elements.com header.a=rsa-sha256 header.s=google header.b=YpB10Rc+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=9elements.com (client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com; envelope-from=tan.siewert@9elements.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcw01BVsz3c1D
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:37:19 +1000 (AEST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so31412355e9.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786091835; x=1786696635; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jEYndMHB+hzzoGm3/jN5rHUQhOLtVYWufPY6GQuzOfA=;
        b=YpB10Rc+0AM3Z2jLNgDWW/Fl3kakeRWSsdGCnik34+nLe8SrI+eLd39GzUQFmag7iD
         Lnw5BSdrcapawC1YS+UepXkp1x/O4QIo6ONiLLl236jWFuv5oaHo4ie1ZF1TgWXrAOY2
         ueU7gIH4b2HlnoJJUu6PZX340abdrbvRjOL5GBiLPeRqeFwc8eEmmU29Au7ccrYCBGxS
         HB5wei8W/dc9g/rDneMeshQ66aIplF2YolnfvtuSnMRLGo582DGETzXoGCLA3EdhvYeO
         tQkxiqMyoOR8I8mMiY8B3wWyMSvggCAlvXde1Mgp80MmrmH9TpEObZrkZ9x3fNI/3Uk6
         r4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091835; x=1786696635;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEYndMHB+hzzoGm3/jN5rHUQhOLtVYWufPY6GQuzOfA=;
        b=YkVPspBCqd8pvRv7IXTMmPWhJ/rIk40r5SsUss5++kt3q1XVkZ14vWO2gNGpNiwjWP
         ya58LfvGJJrVzxKWKkGClIu18FeI1ZVY+eTvSb3DaK2bceN393iv9BZq761Cdvj6uaty
         FpOLYGT99eZNgiFHtnmX0ak3mK7exW0B57Vxd66B2XQX9Xp+nUyRqbLKnsj5kPqet6Jy
         xZ6W9+nHOrA5nZCzLVhFlritZ68GO71b8yLWo8BOKU14zh2cbX4Y7hkXNETyxlxQRsfR
         E1w59qWc3C9T6CBmagqKWCiXl7EPspy0Yke6htI8kSa/LwtzJmohn3hjt4CyMX4JKN+J
         07Rw==
X-Forwarded-Encrypted: i=1; AHgh+RqqdMAl7B+EqLBGAZNrgsMrUNKGX+1agGDolNiQnvbVEkZg3cAgm0rV9JV/zSLoQ8f53LQ93uUlEMYcELI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YypVRJP2rYJ8Fh2QsDBNvbCukGwIN/5lCfV9oikuAeSUh34nh1s
	nxjEdyUaa9crjoEYsFyxXowR+/sv2EXWG1SQVDIXldgshxsZRZePOqGtjTK7Pmr8b6oFwJCERlk
	q7gieVMqSKg==
X-Gm-Gg: AR+sD12I/Cy6/uaru7w7CcGO52SudgGnOxEDlN5n2ZMuM0dHqAsHkzYQuPNi+/5N0z9
	dD3AoAsMyZGgEhSzJ+F3FIZ1itnKd7shxdM8MsInWaGDrgmbE5dWFmO6US/5m0Bjy38uY2BfJrn
	UWtY8hx6ZHN5mxcPWM0aYSItYolYCbt726U5hUXKu+McMrbr1TfjgyUhz7oblLMzDVXrzHRhRad
	i++hlMwFezu/pC4asLJ/bmBnrl/cAQrXIBD6Hh8nVcewYNkjPyVNlMmGkbAdnfTHH5n8YOZbmWa
	4qmAvNASHi4w6aUMBTy40nKM2WmLooGBaptjEaHZYT4MLFOULpo15ycUDgqZzUItQrY838m68GO
	rd2S9MghOa5Ia7Ijdnb4z0QwdR0JEbZR6q1Lyake3eDmjlb/5TpqLcc61Ai8ezAJ1yKh4BQy0cN
	OJVkP/ApqDG71eA+rXgsL3IevkHkWSslKK41eQhRUjI+F2A9qW2gNfSJ6RQA6Lvkl1rMPNKsc=
X-Received: by 2002:a05:600c:a47:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-49959e2eb00mr92663195e9.9.1786091835248;
        Fri, 07 Aug 2026 01:37:15 -0700 (PDT)
Received: from [172.20.10.3] ([2a01:599:843:2744:7f5d:3df0:76c1:3705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e7171sm17795195e9.1.2026.08.07.01.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:37:14 -0700 (PDT)
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
Subject: Re: [PATCH v5 3/6] serial: 8250_aspeed_vuart: add VUART over PCI
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
In-Reply-To: <84efc6b23b79e901245e9ed7f58546bef6089530.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <84efc6b23b79e901245e9ed7f58546bef6089530.1785932211.git.gregoire.layet@9elements.com>
Date: Fri, 07 Aug 2026 10:37:09 +0200
Message-Id: <178609182923.193353.14922851647951168548.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091831; l=504;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=P/41CvtTcGae/equIvztsQBGuXVGaJoauUSj4lEXoMo=;
 b=w8BqgggHC8+rKIIYkDpF4V+LQxQsLNTjAkqs8Mvxlj5omkapBkoZ7qOK3HWj+EyFPq5fEadKj
 1czd/NMPD8ADtaa6dibTAstN19JKAfgQvZMVKV0WiyJ9NIMbbW8jdIf
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

On Wed, 05 Aug 2026 14:19:50 +0200, Grégoire Layet <gregoire.layet@9elements.com> wrote:
> Enable the VUART over PCI for the AST2600. Activate it only if the
> 'aspeed,vuart-over-pci' property flag is set on an
> 'ast2600-vuart' compatible node.
> 
> The AST2600 has 2 VUART that are usable over PCI. These are already
> defined as the VUART3 and VUART4 in the 'aspeed-g6.dtsi'.
> 
> [...]

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>

-- 
Tan Siewert <tan.siewert@9elements.com>

