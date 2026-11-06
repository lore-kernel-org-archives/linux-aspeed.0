Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948CE606A329
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KbVDF/ZZ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLSL80Qbqz2xHG;
	Fri, 06 Nov 2026 16:25:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793942703;
	cv=none; b=oFuX4y0b4xAoOPTA9wlluW5xTZLyi15UJMYhNkiCuboP5+Vm3Ww0KQe+gF1vCeOX25+xhgR1y0SjyUSb59290tqHZJR5kwsupxxkWzi4/X2knDLTiyuNlmNMprGt+MIvmHCg1GVwcxoYFdRMYPAh/gTM1KpXKQGgHg4XchL6EZesdRiXA45UHSJ+4A1w83sM1aG93JvwwSFEGFQ9v5x6jhsxLUxGO2k15jJFUUMDvENWoda23GgGl3GvOosZnVE/xGkZ2cbqvZGslnTgq4NcUr6fVHmrUOclg6N95UdjNjDLFw1+zVUXU9jxf8XoQBNdRK50IgkIihTY7RJWpbYW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793942703; c=relaxed/relaxed;
	bh=rc1B5L9x4KU9XV5a9KjL0IyzS9SFrFYxX5fwdEU8zEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QFKPrbBfHflu7TaGLNqX9YYfKAs2W5UqgAtPiDTd+a9JAGExbsN4Uhu3chf9eMrWKcD/OGfGMiJ0OH5pqAPmb0RyaPiPfuYtYlzZ7gbUemFv63aCnWKc9PgRrMyOqNwsuAjQPGsxDbi4FHr1T8OFK/J7Ehb4D7t3GgmxjWQtJ+UrqieRi3/tzsjcEiGCaYjtswjCwrLC3AW96ZQSsD3Fffpw1k2d6ah6wMZ36zXk3E2NS6dGeQKqBkNrHc2/vaZvQOzw18fBwYm1nAEEja5eDrS3tG7KHvSdZtexgUfmxUOdFmcbA2SoKvDUj9c/tfTp19F/Kd1MN+cmjmzFkJ64QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KbVDF/ZZ; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=KbVDF/ZZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLSL72GQcz2xGr;
	Fri, 06 Nov 2026 16:25:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793942702;
	bh=rc1B5L9x4KU9XV5a9KjL0IyzS9SFrFYxX5fwdEU8zEU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KbVDF/ZZlKW+8X1Vp2xhdZH2JdZ3LdHuFkg7F0ExZz3B9V4shzzGT9MBmcdhE15A0
	 rwHSBsy2yR3p+qiDcq2LPyXE2wvePRvsmBh6ty6wjvi5jNHIiQ4umHU8eOjB/k7TWe
	 6JZhmgwkXkl+4HNSvAuqhn/fK3Q6cqxx6ti/kb1TsfBBj4SnWQr5h8jjPv+axoLuKr
	 UtSvFIikSTMKKGzLeOQFjUkG8UBZhABXcMrtcWTsYTijokWRofu2bP5aeKZR79XU2p
	 TgfhhjDipdr5JOrq2deYgHexwEDM8p9PyYj4dVOzUvx380bjRberr47UdzK6+kOeU3
	 /RfaOavucwNag==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0978A64952;
	Fri,  6 Nov 2026 13:25:02 +0800 (AWST)
Message-ID: <69a28877e3ed57f9f248d31d1972b62446a4d230.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 0/2] Aspeed GPIOP handover with managed controller
 lifetime
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>, 
	linusw@kernel.org
Cc: joel@jms.id.au, ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com, 
	brgl@kernel.org, tan.siewert@9elements.com, linux-aspeed@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 06 Nov 2026 15:55:01 +1030
In-Reply-To: <20261106022907.10735-1-prasanth.padarthi10@gmail.com>
References: <20261105152348.8567-1-prasanth.padarthi10@gmail.com>
	 <20261106022907.10735-1-prasanth.padarthi10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-06 at 07:59 +0530, Prasanth Kumar Padarthi wrote:
> This series continues the AST2600 global-to-local GPIOP passthrough
> handover work, rebased on v7.4-rc1. It adds a shared pinctrl lifetime
> fix before the G6 handover change.
>=20
> The registration lifetime issue was identified by automated review:
> the G6 callback data is devm-allocated, while the shared helper used
> unmanaged pinctrl registration. Patch 1 switches registration to
> devm_pinctrl_register(), ensuring unregister runs before earlier
> devres allocations are freed. Patch 2 retains the v3 handover logic.
>=20
> Changes since v3:
> - Add managed registration as a separate prerequisite patch.
> - Keep the handover implementation unchanged.
> - Add KASAN lifecycle testing in QEMU and on B650D4U hardware.
> - Update validation statements to distinguish lifecycle and power tests.

Can you please re-send v4 so it's not threaded under v3?

Also, I received the v4 cover letter twice. Something seems wrong with
your mail setup.

Andrew

