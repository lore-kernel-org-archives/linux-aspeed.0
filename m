Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6024606A31C
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 02:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QtmdzpEM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPS1j13Zyz2xMQ;
	Wed, 11 Nov 2026 13:21:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794363673;
	cv=none; b=XtS0qpL0C05ELTRZVqi4xMmBd6wxJfbeVkDRpQTY4OUmlGuJMhaYm2/nI0BHWMXgW4Z8FpkY+fb7+CKKtJEGR37MnQKuNd8qQXhbZSJnQ09prtuNyKOGsV0kIoNuq/j0wJthgwRHr2b66n1734FdW2z3s5tU8PuupCQ+H2M9uBdGPpywxRfPm8Anrelvao7k0y8JHOQe0DWqx8rMYjW5NOje8ivzA2aEE/CYdL4uUSnZ6Avd1lSJbo+XJriIh8hO8j5oq8D0L7HTwcaCDWqZybhQIJV0/hOGwI+lH8M7TKbW+nyJmPuwP1q7Uekati5t+dTAQ9WG46+n6nYPWCYmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794363673; c=relaxed/relaxed;
	bh=I4GBhnkL8TbOzob3Wovtp6qk4K24+RzN6Xk5hbAk0Ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jlCvtFAt19fY/+HiwPYJCQNnLwVYmhYywOupY1TQ4Zo84GILXllSebidqikySGtRadZbRSzEK3BbKLxNVzbHJGMoeiamq8utig7VGUvUw3/ApT7TIHD/DL1Xiq5CDVLi5wDgCrUpjJGguSQbxsz5uYgsPG0yMgA0rPjz23k9fY3nscjEhq5pDuGUbYm+oEr90ffR7Gx4XF2UGTwr2FNpnI0Je/GAg4xaOlEuA7/ZhhsPGA7zxlPJQ3+fuBCujxXnwy/kj151Q8Lj5DtfAXuqPYSP2Q8lX9tXXQbPgIcStDYmwx8HEYjTLe21ohPlKUQN066H49xZ64yEkC4r4HajhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QtmdzpEM; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=QtmdzpEM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPS1h4gV4z2xGg
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 13:21:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794363671;
	bh=I4GBhnkL8TbOzob3Wovtp6qk4K24+RzN6Xk5hbAk0Ak=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QtmdzpEMtcHmZ6A20VSY0hFQyy2l3PaT6QOvQSjHOMW5g2fwf8UwTuzDwbDrkWmut
	 rkKVFDBBPILMrE3J0DDA2hQ1GV2iH7z+SeNsDaNI6x4XQKkf+MHll++OI01OGjESc/
	 s/3HM4eMKetqfi8Qb+BuLaJlt3/3MYevt9keBTQFmNuHBB0TcDjR0DW0QVJAnnVBSv
	 6eD2HCQXI3KDkeUCyHzJWOsNH+rRqsVGHQn10PhYM5QmsNjVV+DUsx1Dp3KyIEAlFv
	 NbzDTTylft2VJ9iv0egTDwWwPIjyq7e9QAmYqdP+PVIWmfy+lff2yy//B0OYucvu8h
	 dcLWBzvlTxt9Q==
Received: from [127.0.1.1] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A78E964C3C;
	Wed, 11 Nov 2026 10:21:11 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Tan Siewert <tan.siewert@9elements.com>
Cc: Ryan Chen <ryan_chen@aspeedtech.com>, 
 Billy Tsai <billy_tsai@aspeedtech.com>, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260819-aspeed-reviewer-myself-v1-1-bec3874cfcd7@9elements.com>
References: <20260819-aspeed-reviewer-myself-v1-1-bec3874cfcd7@9elements.com>
Subject: Re: [PATCH] MAINTAINERS: add Tan Siewert as reviewer for
 ARM/ASPEED
Message-Id: <179436367163.2554644.7658720316949803236.b4-ty@b4>
Date: Wed, 11 Nov 2026 12:51:11 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 19 Aug 2026 14:26:12 +0200, Tan Siewert wrote:
> I'm volunteering to help review patches for the ASPEED SoC support.

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


