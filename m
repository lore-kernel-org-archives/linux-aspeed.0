From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 11 Sep 2020 09:12:11 +0800
Subject: [PATCH 2/2] gpio/aspeed-sgpio: don't enable all interrupts by
 default
In-Reply-To: <CACPK8XdOTorJcNSON--LZU8XkWLh5kwXc8fkGWOBmXVnFiCnSQ@mail.gmail.com>
References: <20200715135418.3194860-1-jk@codeconstruct.com.au>
 <20200715135418.3194860-2-jk@codeconstruct.com.au>
 <CACPK8XdOTorJcNSON--LZU8XkWLh5kwXc8fkGWOBmXVnFiCnSQ@mail.gmail.com>
Message-ID: <5d953d84c8b84d182068329db124517f8c5603b8.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Joel,

> And also removing the enabling of IRQs. This part makes sense, as
> it's what the commit message says.
> 
> If you think a sensible default should be single edge (and I would
> agree with that change), perhaps update the comment to say "set
> single edge trigger mode" and mention it in your commit message.

OK, shall do. That was my intention with the "reasonable defaults"
reference, but being explicit about that better here.

I'll send a v2 with an updated commit message.

Cheers,


Jeremy


