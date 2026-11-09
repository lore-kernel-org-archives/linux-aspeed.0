Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E26606A339
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Nov 2026 05:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=egf84Gcq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNJ3P5RPHz2xdb;
	Mon, 09 Nov 2026 16:18:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794201521;
	cv=none; b=CuC837uc5oeU+2Rj+m3hN+w7LqYqrfUD9hChO+OBYh+t/7cN1YPtkwMkpkbdaOoibO5vAd//sKbsM+t5Hx12fnX5TCzh6Yex0HuczHZVq9V9CHNS20LebBZxXjkdsTHbLgEsBcrLg1hq61giWzCqx5dREaGAtFCG/mPHjY3E/48mhSM1guiFwVk96SvliK4qupprHOFW8yvf95tLWg5V/1ktWARnZEcMlJwQPIF+jxGCBafv5rytPWxVX7ZW4ANfS/w4ZEsaBxhuEiRgKGZmnpsUfF8BLzU/tuZASBRpHXuOOQ0ynmuzKM3Lf6FjuiuPpTf6tjY/MM/g9KANkRx+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794201521; c=relaxed/relaxed;
	bh=inbRv9rqETpvmrvWY+hsNFNboYN1tmYS0qnuK2Kr/gs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g+N7QtWGT8RMKdbLZcXmH66EowiJjd7uuEyQJmX/ZMV5AMMQYfuOrNK3Vjo8S8sN3FjISY4ZwT171yODCHIDLk12qSmWRbI94Eo1nUtqJtEVRHl9e4s3oti7w91qmDVsbRB/E2eO7qn1f0ICQmcGFSczYHNP4ntCU+Z0EwPi/Yv/MQcX1bbW1BkWupCgXsIR27vaQFp+tdQW8QSWTX5/qy8rxjLSnk2wQGeiW34CafDD2KiRlyUQO19AuLxKFZBsfbH+aY7quOa40eI/SJNRJHVkCYizFHkC8HGfldXTgUMNZRvhUl9vUzKTKvspCZCDzYK6BgCCpohxvS9uNunDSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=egf84Gcq; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=egf84Gcq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNJ3P0Rnjz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 16:18:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794201519;
	bh=inbRv9rqETpvmrvWY+hsNFNboYN1tmYS0qnuK2Kr/gs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=egf84Gcqai+t2RbzRcp/hsSqUjhQHhjh3vyzhBpm8hV2KWxqDFJxnPUahIU113EcT
	 BgLm6wqU/Euo4rhk1oHtIX3Z9zvOL05mtWbK6K/L7+70zAOa6b9LxPeqiMFkTfAyXR
	 sJ6r+I/RKBuOwB8hQ4kh0KzVB0J735kCbnMQRQlA7QvM+MYWUHFrMnQcdvVsUlq4qL
	 OrhgI7yGlCRf9GdwPQCvkWPbpW6LqMolW9oQ7mrzBne/qL9+nOjj/aqp3F164dsqk2
	 7rLero/HB4L0DSs1r+ug01+7VgG2RcG87tSeq7M4AqhpAUCMcl+W2qQMRVuMpXb4J2
	 kfa7LW520ih5Q==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 083566E9E9;
	Mon,  9 Nov 2026 13:18:31 +0800 (AWST)
Message-ID: <4848c58f3152233477c4fa4786de2a49c9261c9c.camel@codeconstruct.com.au>
Subject: Re: [PATCH 09/14] soc: aspeed: convert LPC and P2A control mmap
 hooks to mmap_prepare
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Juergen Gross
 <jgross@suse.com>,  Stefano Stabellini <sstabellini@kernel.org>, Oleksandr
 Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan	
 <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael
 Ellerman	 <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,  "Ritesh Harjani (IBM)"	 <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang	
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui	
 <decui@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang	
 <jasowangio@gmail.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>,  Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko
 Sakkinen <jarkko@kernel.org>, Dave Hansen	 <dave.hansen@linux.intel.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar	 <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Jan Kara <jack@suse.com>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej =?UTF-8?Q?Mosn=C3=A1=C4=8Dek?=	 <omosnacek@gmail.com>, Joel Stanley
 <joel@jms.id.au>, Ryan Chen	 <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konradybcio@kernel.org>, Abel Vesa	 <abelvesa@kernel.org>, Jens
 Wiklander <jenswi@kernel.org>, Sumit Garg	 <sumit.garg@kernel.org>, Scott
 Branden <scott.branden@broadcom.com>,  Broadcom internal kernel review list
	 <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran
 <richardcochran@gmail.com>, David Woodhouse	 <dwmw2@infradead.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller"	 <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski	 <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-hyperv@vger.kernel.org, 	virtualization@lists.linux.dev,
 linux-sgx@vger.kernel.org, 	selinux@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, 	linux-aspeed@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, 	op-tee@lists.trustedfirmware.org,
 netdev@vger.kernel.org
Date: Mon, 09 Nov 2026 15:48:30 +1030
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-9-c56aadfbab8a@kernel.org>
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org>
	 <20261105-late-2026-mmap_prepare-v1-9-c56aadfbab8a@kernel.org>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 21:05 +0000, Lorenzo Stoakes (ARM) wrote:
> Move from the deprecated mmap hook to the new mmap_prepare hook for both
> the LPC control and P2A control drivers.
>=20
> Both remap a range of their reserved memory region, so use the PFN remap
> mmap action to do so, retaining the -EAGAIN error on failure via the acti=
on
> error override.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

