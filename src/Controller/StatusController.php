<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class StatusController extends Controller
{

    public function index()
    {
        return $this->render('status.html.twig', [
            'list' => [1, 3, 5, 3, 2]
        ]);
    }

}
