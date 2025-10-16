Return-Path: <linux-aspeed+bounces-2476-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69ADCCD183
	for <linux-aspeed@archiver.kernel.org>; Thu, 16 Oct 2025 20:50:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cng8B13JWz30Vl;
	Fri, 17 Oct 2025 07:50:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760647834;
	cv=none; b=BgA74D8higFKVUc/LYKcrpoqELZ8+5JdjkBAtq/lmUt1wdl24VEok0Y8yFu0F1O6snUyyBFDSU5ssUWgkDRxX04tGF625t9TXtOo80DS/f0zm7Yk8U0AakeHw5AQpSWA4Nb7cNaYNCZ3U0aMS/JJEHx3p9IckQO4Ty6+4RzIWuZlgB6JxInCCxVqD5TZKJ6ASch77iTYPThlgfJOTnfw/gr/9s6EGpENERs3gskdREJkxCBb2sGVnGJZ54odKbCVT3w2VgmyyD98kLBf+Se5tQXsA0b8ZVxUwCyk0fdXbHr81KeXad5WrISYqAe+LVxPH56q6E/+PFxt+fZqUIGR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760647834; c=relaxed/relaxed;
	bh=uzI4Ut12pJAKPtvzuGciHzIkIU66wAwYHAzNsh79YvE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FQcGRt+LuBthTj+FDdTMPniCtYClfC2nSI/0HdoXcKuGlKXpcoz5DmnhrNBEwY9vjCVgYDWSXdSZ20GLZjslDMqT6V8DQfLIS9Go/Az0YQVMA5UbOabZbmFA8MmJudBaRdCv/9yFgk6g25eCxsgAk/qaGKg9w72v+utcAIQ2uQLrNyJQKVq9pkZU878qeVhgYplSryLZHIS/1WvZ+khrcbFOZjGm/K70IxmiI0IW+sv0OVvbJ1wiW2+iAqcSUWsEjP8p9Hs1f4DKL4fQYDe2BJIRKV0pVR0FN9mWUGbpMhJ86gl4Lve3SV3H3Mv6aajHvsFj+az/0pYepxR5EPxHzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=k+Lz5rZB; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=k+Lz5rZB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cng8919byz2yGM
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 07:50:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D12DD44929;
	Thu, 16 Oct 2025 20:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA14C4CEF1;
	Thu, 16 Oct 2025 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760647829;
	bh=ITlIzUAUo5pssT1lw+5f7WFRnL9FQktvSQ7YkS/Swf4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=k+Lz5rZBobuGND9FUYtJH8NH5vh9PWxwRUoTE04ieCY9L1ZYOEv6KSowX27XvzdvQ
	 Z3RDm/K4iKRxg0IJDOOqW0Ghs7z6YfksWl1db3oe8w7t5je78shZgX1cFiARrxlpS/
	 ANZCwotNwcmuyftujQphlq2yleXvWJEdvZcSQEcI=
Date: Thu, 16 Oct 2025 13:50:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Lance Yang <lance.yang@linux.dev>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "wireguard@lists.zx2c4.com"
 <wireguard@lists.zx2c4.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Arnd Bergmann <arnd@arndb.de>, David
 Hildenbrand <david@redhat.com>, Florian Wesphal <fw@strlen.de>, Jakub
 Kacinski <kuba@kernel.org>, "Jason A . Donenfeld" <jason@zx2c4.com>, Joel
 Granados <joel.granados@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Liam Howlett
 <liam.howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Petr Mladek <pmladek@suse.com>,
 "Phil Auld" <pauld@redhat.com>, Randy Dunlap <rdunlap@infradead.org>,
 Russell King <linux@armlinux.org.uk>, Shuah Khan <shuah@kernel.org>, Simon
 Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Steven
 Rostedt <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: =?UTF-8?Q?[=E5=A4=96=E9=83=A8=E9=82=AE=E4=BB=B6]?= Re:
 [PATCH][v4] hung_task: Panic when there are more than N hung tasks at the
 same time
Message-Id: <20251016135028.aea65e20b0bc7efee11572f1@linux-foundation.org>
In-Reply-To: <bb443552b6db40548a4fae98d1f63c80@baidu.com>
References: <20251015063615.2632-1-lirongqing@baidu.com>
	<4db3bd26-1f74-4096-84fd-f652ec9a4d27@linux.dev>
	<bb443552b6db40548a4fae98d1f63c80@baidu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 05:57:34 +0000 "Li,Rongqing" <lirongqing@baidu.com> wrote:

> > If you agree, likely no need to resend - Andrew could pick it up directly when
> > applying :)
> > 
> 
> This is better;
> 
> Andrew, could you pick it up directly

No problems, thanks.

