Return-Path: <linux-aspeed+bounces-1131-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5315C36002
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Mar 2025 23:59:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZM94s2QT4z2yFJ;
	Tue, 25 Mar 2025 10:59:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742860749;
	cv=none; b=fMdz0jruXoAJIz5Lf+dN9aQk+8ft8aKW2/JJz0vLW5jRhRieV3ENCOii7Sffm6h9DxrD74JGWlJ0PL6Am6AiN6lntVbDCVWC56Q7KhjmhtrvpC/2Pv8YM7fa3T3qVKD8l6Hj9xVfvWFQ8SJ1MIYeQzL6YNAjupJgpEACKLCceY3/OhyS3yTCgpR0X57Ac7BPHTMVzNjd2G/DlrWf9/l4vR9rB+4DPgkofRqEoycRPH39I7V9AuQWa22QjB2Ce7whZm1/TaUwvnr5xHfXE4fqbJUsCfj/wNuVYNNkKrq4feEM3MIYbVcott9K+6+N06oWQLyoi/lrrUC3ogcqNOLrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742860749; c=relaxed/relaxed;
	bh=FWdFElbolN32IcSIukRd2p8E/VsngBvOblp9fg+S+xY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=P1vJ2I9l2BUErirH6jsQMMCk0ztm2bicbvD7Bu0aWXNQnzK2Lv8Ytr20g1Igs4iu4BnJfA+XmcWQvGFQeGKGkDyJ14MNTlAGJMXmwPX2QuiByTY+4s4EuJ7eg8u1Bh9UxWuYOWdh06l0r2I4lQE87mwOPcLcNLwDlVtqZj1AJIjrMRhR4/fcrosAEIGClBJ7m6GhfX4BSjFa3gLDJLtVvIBFV8ZhyC8AxM9/LJopGWQeVhNCYcANuzTIeSja1UxbYtd/ySVwdthbDuaESPuEN3vV0sZVkGEMW91WAFhnYy6WGBspmDKGsNklpi2GLTHbOpPAMomVlCIgkJ8trMKanA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=gS0Iydm/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=gS0Iydm/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZM94r6CMzz2yDr
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Mar 2025 10:59:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742860748;
	bh=FWdFElbolN32IcSIukRd2p8E/VsngBvOblp9fg+S+xY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gS0Iydm/MeDjtnLSJdBetps1Xv0ZUqMP2L6gevOdlk9P4BuYUJa3X0+mAzh1KELYu
	 RpqKP0F7rqM7clhL4pPXc5sbOKWMm35GLhEwqB3ENEiQcSCiWPOJv4shasRNZrbEc7
	 N2bJK6ywGbu70kOZ9nQRl9AOtaLLwky/V6fCLtKmsoYGKtqm9ONzJEU5wYDUc9oKOk
	 u9KnOXA7OcCT/GnzMbnsg6wbc+/kZe35QawZCbDj+kovJCXAhJDPVf++U5iRpxjRT+
	 eGuYM063/xkB2Qmj2s+cGbijNsGY2zjC8ppTiwhL2whiZ/0+ymmAH/3/qdzgiGMWn1
	 F73EryAwms/Rw==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A8CEC7B506;
	Tue, 25 Mar 2025 07:59:06 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
Subject: Re: [PATCH v6 00/10] ARM: dts: aspeed: catalina: Update DTS to
 support Catalina PVT hardware
Message-Id: <174286074647.923686.7149650911621706997.b4-ty@codeconstruct.com.au>
Date: Tue, 25 Mar 2025 10:29:06 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Fri, 21 Mar 2025 15:26:01 +0800, Potin Lai wrote:
> Update the DTS file for the Catalina platform based on the PVT hardware
> changes.
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


